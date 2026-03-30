function success = ensure_dir(dirPath)
    % ENSURE_DIR - Create directory if it doesn't exist
    %
    % Inputs:
    %   dirPath - Path to directory to create
    %
    % Outputs:
    %   success - True if directory exists or was created successfully
    %
    % Example:
    %   ensure_dir('Data/Processed');
    %   ensure_dir('Data/Figures/LP_Results');
    
    if exist(dirPath, 'dir')
        success = true;
        return;
    end
    
    try
        mkdir(dirPath);
        fprintf('Created directory: %s\n', dirPath);
        success = true;
    catch ME
        warning('ensure_dir:CreateFailed', ...
            'Failed to create directory %s: %s', dirPath, ME.message);
        success = false;
    end
end
