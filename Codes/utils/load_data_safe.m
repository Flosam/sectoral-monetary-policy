function data = load_data_safe(filepath, varargin)
    % LOAD_DATA_SAFE - Safely load .mat file with existence validation
    %
    % Inputs:
    %   filepath - Path to .mat file to load
    %   varargin - (Optional) Variable names to load. If empty, loads all.
    %
    % Outputs:
    %   data - Structure containing loaded variables
    %
    % Example:
    %   data = load_data_safe('Data/Processed/Price_Index_Data.mat');
    %   data = load_data_safe('Data/Processed/Price_Index_Data.mat', 'price_log_lvl');
    
    % Validate file exists
    if ~exist(filepath, 'file')
        error('load_data_safe:FileNotFound', ...
            'File not found: %s\nPlease check the path and ensure the file exists.', ...
            filepath);
    end
    
    % Load data
    try
        if isempty(varargin)
            data = load(filepath);
        else
            data = load(filepath, varargin{:});
        end
    catch ME
        error('load_data_safe:LoadError', ...
            'Failed to load file %s\nError: %s', ...
            filepath, ME.message);
    end
    
    % Validate data was loaded
    if isempty(fieldnames(data))
        warning('load_data_safe:EmptyFile', ...
            'File %s exists but contains no data.', filepath);
    end
end
