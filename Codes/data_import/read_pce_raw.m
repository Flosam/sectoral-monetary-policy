function [pce_quant_all, pce_price_all, categories, dates] = read_pce_raw()
    % READ_PCE_RAW - Read raw PCE data from CSV files
    %
    % Reads PCE Quantity Index (2.4.3u) and Price Index (2.4.4u) from BEA
    % and performs initial processing (parsing dates, category names).
    %
    % Outputs:
    %   pce_quant_all - Timetable of quantity index data (all categories)
    %   pce_price_all - Timetable of price index data (all categories)
    %   categories - Cell array of category names
    %   dates - Datetime vector of observation dates
    %
    % Example:
    %   [quant, price, cats, dates] = read_pce_raw();
    
    % File paths
    filename_q = "Data/Raw/PCE Quantity Index.csv";
    filename_p = "Data/Raw/PCE Price Index.csv";
    
    % Validate files exist
    if ~exist(filename_q, 'file')
        error('read_pce_raw:FileNotFound', ...
            'Quantity index file not found: %s', filename_q);
    end
    if ~exist(filename_p, 'file')
        error('read_pce_raw:FileNotFound', ...
            'Price index file not found: %s', filename_p);
    end
    
    % Configure import options
    opts = detectImportOptions(filename_q);
    opts.DataLines = 6;
    opts.VariableNamesLine = 4;
    
    % Read tables
    fprintf('Reading PCE data files...\n');
    pce_quant_og = readtable(filename_q, opts);
    pce_price_og = readtable(filename_p, opts);
    
    % Get category names from column 2 - use all rows in the table
    % Original code didn't auto-detect, just used all loaded rows
    categories = table2array(pce_quant_og(:, 2))';
    categories = cellfun(@strtrim, categories, 'UniformOutput', false);
    
    fprintf('Found %d category rows in data\n', length(categories));
    
    % Ensure categories is a cell array of character vectors
    if ~iscell(categories)
        categories = cellstr(categories);
    end
    
    % Check for empty category names
    emptyIdx = cellfun(@isempty, categories);
    if any(emptyIdx)
        fprintf('Warning: Found %d empty category names, replacing with placeholders\n', sum(emptyIdx));
        categories(emptyIdx) = arrayfun(@(x) sprintf('Category_%d', x), ...
            find(emptyIdx), 'UniformOutput', false);
    end
    
    % Trim names that exceed character limit for table variable names
    categories = trim_long_category_names(categories);
    
    % Ensure all category names are valid MATLAB variable names
    % Convert cell array to proper format for makeValidName
    categories = cellfun(@char, categories, 'UniformOutput', false);
    categories = matlab.lang.makeValidName(categories, 'ReplacementStyle', 'underscore');
    
    % Ensure unique names (in case makeValidName creates duplicates)
    categories = matlab.lang.makeUniqueStrings(categories);
    
    % Get dates from column names
    datesCols = pce_quant_og.Properties.VariableNames;
    dates = parse_column_dates(datesCols(:, 3:end))';
    dates = datetime(dates);
    fprintf('Data spans from %s to %s\n', datestr(dates(1)), datestr(dates(end)));
    
    % Transpose data and transform into timetable
    pce_quant_og_trim = pce_quant_og(:, 3:end);
    dataMatrix_q = table2array(pce_quant_og_trim);
    pce_quant_trans = dataMatrix_q';
    
    pce_quant_all = array2timetable(pce_quant_trans, ...
        'VariableNames', categories, 'RowTimes', dates);
    
    pce_price_og_trim = pce_price_og(:, 3:end);
    dataMatrix_p = table2array(pce_price_og_trim);
    pce_price_trans = dataMatrix_p';
    pce_price_all = array2timetable(pce_price_trans, ...
        'VariableNames', categories, 'RowTimes', dates);
    
    fprintf('Successfully loaded PCE data: %d categories, %d time periods\n', ...
        length(categories), length(dates));
end

function categories = trim_long_category_names(categories)
    % TRIM_LONG_CATEGORY_NAMES - Shorten category names exceeding MATLAB limits
    %
    % MATLAB has a 63-character limit for variable names. This function
    % shortens specific long category names.
    
    categories{26} = 'Clocks, lamps, lighting fixtures, and other decorative items';
    categories{39} = 'Video, audio, photo, and info processing equipment and media';
    categories{51} = 'Calculators, typewriters, and other info processing equipment';
    categories{74} = 'Food and nonalcoholic beverages for off-premises consumption';
    categories{138} = 'Hair, dental, shaving, and personal care products';
    categories{180} = 'Outpatient care facilities, health and allied services';
    categories{210} = 'Membership clubs, sports centers, parks, theaters, and museums';
    categories{218} = 'Audio-video, photo, and info processing equipment services';
    categories{222} = 'Repair & rental audio-video, photo, info processing equipment';
    categories{233} = 'Maintenance & repair of rec vehicles and sports equipment';
    categories{256} = 'Other depository institutions & regulated investment companies';
    categories{307} = 'Personal care and clothing services';
    categories{342} = 'Final consumption expenditures of NPISHs';
    categories{352} = 'Foundations, grantmaking & giving establishments, gross output';
    categories{356} = 'Less: Receipts from sales by nonprofit institutions';
    categories{364} = 'Religious organizations services to households NPISH';
    categories{365} = 'Foundations & grantmaking & giving services to households NPISH';
end

function colNames = parse_column_dates(ogCols)
    % PARSE_COLUMN_DATES - Parse column names into date strings
    %
    % BEA data uses format like 'x2020_1' for Jan 2020
    
    colNames = cell(size(ogCols));
    for i = 1:length(ogCols)
        parts = strsplit(ogCols{i}, '_');
        year = str2double(parts{1}(2:end));
        if contains(ogCols{i}, '_')
            month = str2double(parts{2}) + 1;
        else
            month = 1;
        end
        dateStr = datestr(datetime(year, month, 1) + calmonths(1) - days(1), 'dd-mmm-yyyy');
        colNames{i} = dateStr;
    end
end
