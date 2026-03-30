%% Set up
% Initialize paths and create required directories
run('paths/initialize_paths.m');
clear

% Compute PCE and MPS data
import_pce_data;
import_mps_data;
clear;

% Load configuration
config = ProjectConfig.get();

% get pce data
quantPath = config.QUANTITY_INDEX_FILE;
pricePath = config.PRICE_INDEX_FILE;
load(quantPath);
load(pricePath);

% get monetary policy shock data
mpsPath = config.MPS_FILE;
load(mpsPath);
mps_bs = tt_bs(:,1);
mps_bs_ortho = tt_bs(:,2);

%% Set common parameters
mps         = mps_ad;
save        = true;
start_date  = config.DEFAULT_START_DATE;
end_date    = config.DEFAULT_END_DATE;

%% Run Local Projections (using GROWTH RATES for stationarity)
fprintf('\n=== Running Local Projections Analysis ===\n');
fprintf('Using growth rates (stationary data)\n\n');

price_lp = price_gr_lvl;  % Growth rates for LP
quant_lp = quant_gr_lvl;  % Growth rates for LP
func_lp = @get_lp;
plot_lp_func = @plot_lp;

run_all(func_lp, plot_lp_func, price_lp, quant_lp, mps, start_date, end_date, save);

%% Run Phillips Multiplier (using LOG LEVELS - ratio cancels non-stationarity)
fprintf('\n=== Running Phillips Multiplier Analysis ===\n');
fprintf('Using log levels (ratio estimator)\n\n');

price_pm = price_log_lvl;  % Log levels for PM
quant_pm = quant_log_lvl;  % Log levels for PM
func_pm = @get_pm;
plot_pm_func = @plot_irfs;

run_all(func_pm, plot_pm_func, price_pm, quant_pm, mps, start_date, end_date, save);


