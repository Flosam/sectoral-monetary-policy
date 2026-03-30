function macro_controls = import_controls()
    % IMPORT_CONTROLS - Import macroeconomic control variables
    %
    % Imports and synchronizes macroeconomic control variables used in
    % local projection regressions. Data sources are from FRED and other
    % standard databases.
    %
    % Control variables:
    %   - FEDFUNDS: Federal Funds Rate
    %   - FXTWBDI: Trade Weighted Dollar Index
    %   - INDPRO: Industrial Production Index
    %   - PPIACO: Producer Price Index (commodities)
    %   - SP500: S&P 500 Stock Index
    %   - UNRATE: Unemployment Rate
    %
    % Outputs:
    %   macro_controls - Timetable with all control variables synchronized
    %
    % Example:
    %   controls = import_controls();
    %
    % Reference:
    %   Control variables from Aruoba & Drechsel (2023)
    
    fprintf('Importing macroeconomic control variables...\n');
    
    % Define file paths
    data_dir = 'Data/Raw/';
    files = {
        'FEDFUNDS.csv', ...
        'FXTWBDI.csv', ...
        'INDPRO.csv', ...
        'PPIACO.csv', ...
        'SP500.csv', ...
        'UNRATE.csv'
    };
    
    % Validate all files exist
    for i = 1:length(files)
        filepath = fullfile(data_dir, files{i});
        if ~exist(filepath, 'file')
            error('import_controls:FileNotFound', ...
                'Control variable file not found: %s', filepath);
        end
    end
    
    % Import control variables as regular tables first
    try
        ffr = readtable(fullfile(data_dir, 'FEDFUNDS.csv'));
        fx = readtable(fullfile(data_dir, 'FXTWBDI.csv'));
        indpro = readtable(fullfile(data_dir, 'INDPRO.csv'));
        comind = readtable(fullfile(data_dir, 'PPIACO.csv'));
        sp500 = readtable(fullfile(data_dir, 'SP500.csv'));
        ur = readtable(fullfile(data_dir, 'UNRATE.csv'));
    catch ME
        error('import_controls:ReadError', ...
            'Failed to read control variable files: %s', ME.message);
    end
    
    % Standardize date column names (some files use 'Date', others 'observation_date')
    if ismember('Date', fx.Properties.VariableNames)
        fx.Properties.VariableNames{'Date'} = 'observation_date';
    end
    if ismember('Date', sp500.Properties.VariableNames)
        sp500.Properties.VariableNames{'Date'} = 'observation_date';
    end
    
    % Convert dates to end of month for consistency with PCE/MPS data
    ffr.observation_date = datetime(year(ffr.observation_date), ...
        month(ffr.observation_date), ...
        eomday(year(ffr.observation_date), month(ffr.observation_date)));
    
    comind.observation_date = datetime(year(comind.observation_date), ...
        month(comind.observation_date), ...
        eomday(year(comind.observation_date), month(comind.observation_date)));
    
    indpro.observation_date = datetime(year(indpro.observation_date), ...
        month(indpro.observation_date), ...
        eomday(year(indpro.observation_date), month(indpro.observation_date)));
    
    ur.observation_date = datetime(year(ur.observation_date), ...
        month(ur.observation_date), ...
        eomday(year(ur.observation_date), month(ur.observation_date)));
    
    % FX and SP500 already have end-of-month dates, but convert for consistency
    if ~isempty(fx)
        fx.observation_date = datetime(year(fx.observation_date), ...
            month(fx.observation_date), ...
            eomday(year(fx.observation_date), month(fx.observation_date)));
    end
    
    if ~isempty(sp500)
        sp500.observation_date = datetime(year(sp500.observation_date), ...
            month(sp500.observation_date), ...
            eomday(year(sp500.observation_date), month(sp500.observation_date)));
    end
    
    % Apply log transformation to relevant variables (data columns only, not dates)
    indpro.INDPRO = log(indpro.INDPRO);
    comind.PPIACO = log(comind.PPIACO);
    sp500.SP500 = log(sp500.SP500);
    fx.FXTWBDI = log(fx.FXTWBDI);
    
    fprintf('  Loaded 6 control variables\n');
    
    % Convert to timetables using observation_date as row times
    ffr = table2timetable(ffr, 'RowTimes', 'observation_date');
    fx = table2timetable(fx, 'RowTimes', 'observation_date');
    indpro = table2timetable(indpro, 'RowTimes', 'observation_date');
    comind = table2timetable(comind, 'RowTimes', 'observation_date');
    sp500 = table2timetable(sp500, 'RowTimes', 'observation_date');
    ur = table2timetable(ur, 'RowTimes', 'observation_date');
    
    % Synchronize all control variables
    macro_controls = synchronize(ffr, fx, indpro, comind, sp500, ur);
    macro_controls.Properties.DimensionNames{1} = 'Time';
    
    % Report data coverage
    fprintf('  Synchronized data: %d observations from %s to %s\n', ...
        height(macro_controls), ...
        datestr(macro_controls.Time(1)), ...
        datestr(macro_controls.Time(end)));
    
    % Report missing data statistics
    numMissing = sum(ismissing(macro_controls.Variables), 1);
    totalObs = height(macro_controls);
    varNames = macro_controls.Properties.VariableNames;
    
    if any(numMissing > 0)
        fprintf('  Missing data summary:\n');
        for i = 1:length(numMissing)
            if numMissing(i) > 0
                pctMissing = 100 * numMissing(i) / totalObs;
                fprintf('    %s: %d missing (%.1f%%)\n', ...
                    varNames{i}, numMissing(i), pctMissing);
            end
        end
    else
        fprintf('  No missing values detected\n');
    end
end