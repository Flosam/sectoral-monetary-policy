function initialize_paths()
    % INITIALIZE_PATHS - Set up MATLAB path and create required directories
    %
    % This function should be called at the start of main.m to ensure:
    %   1. All code subdirectories are added to MATLAB path
    %   2. Required data directories exist
    %   3. Configuration is validated
    %
    % Example:
    %   initialize_paths();
    
    % Get the directory where this function resides (Codes/paths/)
    functionDir = fileparts(mfilename('fullpath'));
    
    % Go up one level to Codes directory
    codesDir = fileparts(functionDir);
    
    % Go up one more level to project root
    projectRoot = fileparts(codesDir);
    
    % Add all subdirectories of Codes to path
    fprintf('Setting up MATLAB paths...\n');
    addpath(genpath(codesDir));
    
    % Change to project root directory
    cd(projectRoot);
    
    % Load configuration
    config = ProjectConfig.get();
    
    % Create required directories
    fprintf('Checking and creating required directories...\n');
    requiredDirs = {
        config.RAW_DATA_DIR, ...
        config.PROCESSED_DATA_DIR, ...
        config.FIGURES_DIR
    };
    
    for i = 1:length(requiredDirs)
        dirPath = requiredDirs{i};
        if ~ensure_dir(dirPath)
            warning('initialize_paths:DirCreationFailed', ...
                'Could not create directory: %s', dirPath);
        end
    end
    
    % Validate configuration
    fprintf('Validating configuration...\n');
    if config.validate()
        fprintf('Configuration validated successfully.\n');
    else
        warning('initialize_paths:ValidationFailed', ...
            'Some configuration directories are missing. Check warnings above.');
    end
    
    fprintf('Path initialization complete.\n');
    fprintf('Current directory: %s\n', pwd);
end
