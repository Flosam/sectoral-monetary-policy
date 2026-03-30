%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IMPORT_MPS_DATA - Import monetary policy shock measures
%
% Imports monetary policy shock measures from:
%   1. Aruoba & Drechsel (2023)
%   2. Bauer & Swanson (2023)
%
% Created by: Florent Samson
% Last modified: 2025/02/18
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Load configuration
config = ProjectConfig.get();

%% Import Aruoba & Drechsel Data
fprintf('Importing monetary policy shock data...\n');

filename_ad = 'Data/Raw/Aruoba_Drechsel_Data.xlsx';

% Validate file exists
if ~exist(filename_ad, 'file')
    error('import_mps_data:FileNotFound', ...
        'Aruoba & Drechsel data file not found: %s', filename_ad);
end

try
    file_ad = readtimetable(filename_ad, "Sheet", "Shocks monthly");
    
    % Convert dates to end of month
    file_ad.Time = datetime(year(file_ad.Time), month(file_ad.Time), ...
        eomday(year(file_ad.Time), month(file_ad.Time)));
    
    % Extract shock series
    mps_ad = file_ad(:, 1);
    
    fprintf('  Aruoba & Drechsel: %d observations from %s to %s\n', ...
        height(mps_ad), datestr(mps_ad.Time(1)), datestr(mps_ad.Time(end)));
catch ME
    error('import_mps_data:ReadError', ...
        'Failed to read Aruoba & Drechsel data: %s', ME.message);
end

%% Import Bauer & Swanson Data
filename_bs = 'Data/Raw/Bauer_Swanson_Data.xlsx';

% Validate file exists
if ~exist(filename_bs, 'file')
    error('import_mps_data:FileNotFound', ...
        'Bauer & Swanson data file not found: %s', filename_bs);
end

try
    file_bs = readtable(filename_bs, "Sheet", "Monthly (update 2023)");
    
    % Extract year and month columns
    year_bs = file_bs{:, 1};
    month_bs = file_bs{:, 2};
    
    % Validate date columns
    if any(isnan(year_bs)) || any(isnan(month_bs))
        warning('import_mps_data:MissingDates', ...
            'Found missing values in date columns');
    end
    
    % Compute last day of month
    lastDay = eomday(year_bs, month_bs);
    dates_bs = datetime(year_bs, month_bs, lastDay);
    
    % Create timetable with shock measures
    tt_bs = table2timetable(file_bs(:, 3:4), "RowTimes", dates_bs);
    
    fprintf('  Bauer & Swanson: %d observations from %s to %s\n', ...
        height(tt_bs), datestr(tt_bs.Time(1)), datestr(tt_bs.Time(end)));
catch ME
    error('import_mps_data:ReadError', ...
        'Failed to read Bauer & Swanson data: %s', ME.message);
end

%% Validate date alignment
% Check if date ranges overlap with PCE data
% This helps catch potential data mismatches early
fprintf('Validating date ranges...\n');

% Note: This is a basic check. Full alignment happens in get_lp/get_pm
if max(mps_ad.Time) < datetime(2000, 1, 1)
    warning('import_mps_data:DateRange', ...
        'Aruoba & Drechsel data ends before 2000. Check if data is current.');
end

%% Save processed data
fprintf('Saving monetary policy shock data...\n');

output_path = config.MPS_FILE;

% Ensure output directory exists
ensure_dir(config.PROCESSED_DATA_DIR);

save(output_path, 'mps_ad', 'tt_bs');

fprintf('MPS data successfully imported and saved to:\n');
fprintf('  %s\n', output_path);