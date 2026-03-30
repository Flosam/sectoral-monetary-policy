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

%% run Philips Multiplier
% Set some variables for every level
mps         = mps_ad;
save        = true;
start_date  = config.DEFAULT_START_DATE;
end_date    = config.DEFAULT_END_DATE;
price = price_log_lvl;
quant = quant_log_lvl;
func = @get_lp;
plot = @plot_lp;

run_all(func,plot,price,quant,mps,start_date,end_date, save);

%% run ad local projection

p0 = get_lp(price_log_lvl{1},quant_log_lvl{1},mps_ad,'1982-01-01','2008-01-01');
plot_lp(p0,'test',false);


