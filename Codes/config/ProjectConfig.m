classdef ProjectConfig
    % ProjectConfig - Centralized configuration for Sectoral Trade-Offs project
    % Contains all parameters, file paths, and settings used throughout analysis
    
    properties (Constant)
        % Analysis Parameters
        HORIZON = 61;           % Number of periods for impulse response (iH)
        NUM_LAGS = 12;          % Number of lags for VAR (1 year of monthly data)
        
        % Statistical Parameters
        ALPHA = 0.05;           % Significance level for confidence intervals
        Z_CRITICAL = 1.96;      % Critical value for 95% confidence (two-tailed)
        
        % Phillips Multiplier AR Testing Grid
        AR_BETA_MIN = -10;      % Minimum beta parameter for AR grid
        AR_BETA_MAX = 5;        % Maximum beta parameter for AR grid
        AR_BETA_STEP = 0.01;    % Step size for AR grid
        
        % Data Date Range (default)
        DEFAULT_START_DATE = '1982-01-01';
        DEFAULT_END_DATE = '2008-01-01';
        
        % File Paths - Raw Data
        RAW_DATA_DIR = 'Data/Raw';
        PCE_RAW_FILE = 'Data/Raw/PCE_Data.xlsx';
        MPS_RAW_FILE = 'Data/Raw/Monetary_Policy_Shocks.xlsx';
        CONTROLS_RAW_FILE = 'Data/Raw/Macro_Controls.xlsx';
        
        % File Paths - Processed Data
        PROCESSED_DATA_DIR = 'Data/Processed';
        QUANTITY_INDEX_FILE = 'Data/Processed/Quantity_Index_Data.mat';
        PRICE_INDEX_FILE = 'Data/Processed/Price_Index_Data.mat';
        MPS_FILE = 'Data/Processed/MP_Shocks_Measures.mat';
        
        % File Paths - Output
        FIGURES_DIR = 'Data/Figures';
        
        % Lag Specifications
        MPS_LAGS = 2;           % Number of MPS lags in control variables
        PCE_LAGS = 1;           % Number of PCE lags in control variables
        MACRO_LAGS = 0;         % Number of macro control lags (currently not used)
    end
    
    methods (Static)
        function valid = validate()
            % VALIDATE - Check that required directories exist
            % Returns true if all directories exist, false otherwise
            
            config = ProjectConfig;
            dirs = {
                config.RAW_DATA_DIR, ...
                config.PROCESSED_DATA_DIR, ...
                config.FIGURES_DIR
            };
            
            valid = true;
            for i = 1:length(dirs)
                if ~exist(dirs{i}, 'dir')
                    warning('ProjectConfig:MissingDirectory', ...
                        'Directory does not exist: %s', dirs{i});
                    valid = false;
                end
            end
        end
        
        function grid = getARGrid()
            % GETARGRID - Generate beta parameter grid for AR testing
            % Returns column vector of beta values
            
            grid = (ProjectConfig.AR_BETA_MIN : ...
                    ProjectConfig.AR_BETA_STEP : ...
                    ProjectConfig.AR_BETA_MAX)';
        end
        
        function config = get()
            % GET - Return an instance of ProjectConfig
            % Convenience method for accessing configuration
            
            config = ProjectConfig;
        end
    end
end
