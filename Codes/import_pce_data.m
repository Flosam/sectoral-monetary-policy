%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IMPORT_PCE_DATA - Import and process PCE price and quantity indices
%
% Imports PCE Quantity Index (2.4.3u) and Price Index (2.4.4u) from BEA,
% transforms to log levels and growth rates, and splits by disaggregation level.
%
% Created by: Florent Samson
% Last modified: 2025/02/18
% 
% Reference:
%   Data and level structure from Aruoba & Drechsel (2023): "The long and 
%   variable lags of monetary policy: Evidence from disaggregated price indices"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Load configuration
config = ProjectConfig.get();

%% Read raw data
[pce_quant_all, pce_price_all, ~, ~] = read_pce_raw();

%% Transform data
[pce_price_log, pce_quant_log, pce_price_gr, pce_quant_gr] = ...
    transform_pce(pce_price_all, pce_quant_all);

%% Divide into hierarchical levels
[price_log_lvl, quant_log_lvl] = split_by_level(pce_price_log, pce_quant_log);
[price_gr_lvl, quant_gr_lvl] = split_by_level(pce_price_gr, pce_quant_gr);

%% Save processed data
fprintf('Saving processed data...\n');

output_path_q = config.QUANTITY_INDEX_FILE;
output_path_p = config.PRICE_INDEX_FILE;

% Ensure output directory exists
ensure_dir(config.PROCESSED_DATA_DIR);

save(output_path_q, 'pce_quant_all', 'pce_quant_log', 'pce_quant_gr', ...
    'quant_log_lvl', 'quant_gr_lvl');
save(output_path_p, 'pce_price_all', 'pce_price_log', 'pce_price_gr', ...
    'price_log_lvl', 'price_gr_lvl');

fprintf('PCE data successfully imported and saved to:\n');
fprintf('  %s\n', output_path_q);
fprintf('  %s\n', output_path_p);