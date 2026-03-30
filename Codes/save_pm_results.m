function save_pm_results()
    % SAVE_PM_RESULTS - Re-run Phillips Multiplier analysis and save numerical estimates
    %
    % This script re-runs the Phillips Multiplier analysis for key categories
    % and saves the numerical estimates (multipliers, confidence intervals, F-stats)
    % so they can be used to populate RESULTS_ANALYSIS.md
    %
    % Output: Creates 'PM_Results_Summary.mat' and 'PM_Results_Summary.txt'
    
    fprintf('\n=== SAVING PHILLIPS MULTIPLIER NUMERICAL RESULTS ===\n\n');
    
    % Initialize paths and load data
    run('paths/initialize_paths.m');
    config = ProjectConfig.get();
    
    % Load processed data (LOG LEVELS for Phillips Multiplier - ratio cancels non-stationarity)
    fprintf('Loading processed data...\n');
    load(config.QUANTITY_INDEX_FILE, 'quant_log_lvl');  % Log levels for PM
    load(config.PRICE_INDEX_FILE, 'price_log_lvl');    % Log levels for PM
    load(config.MPS_FILE, 'mps_ad');
    
    % Use Aruoba & Drechsel MPS (1982-2008)
    mps = mps_ad;
    start_date = '1982-10-01';
    end_date = '2008-10-01';
    
    % Initialize results storage
    all_results = struct();
    
    %% LEVEL 0 - AGGREGATE
    fprintf('\nProcessing Level 0: Aggregate PCE\n');
    r = get_pm(price_log_lvl{1}, quant_log_lvl{1}, mps, start_date, end_date);
    all_results.L0_Aggregate = r;
    
    % Extract key statistics
    fprintf('  Phillips Multiplier peak: %.3f at month %d\n', ...
        max(abs(r.vBeta)), find(abs(r.vBeta) == max(abs(r.vBeta)), 1));
    fprintf('  Effective F-stat (mean): %.2f\n', mean(r.vFstat));
    
    %% LEVEL 1 - GOODS VS SERVICES
    fprintf('\nProcessing Level 1: Major Categories\n');
    categories_L1 = price_log_lvl{2}.Properties.VariableNames;
    
    for i = 1:length(categories_L1)
        fprintf('  %s...\n', categories_L1{i});
        r = get_pm(price_log_lvl{2}(:,i), quant_log_lvl{2}(:,i), mps, start_date, end_date);
        field_name = sprintf('L1_%s', categories_L1{i});
        all_results.(field_name) = r;
        
        fprintf('    Phillips Multiplier peak: %.3f at month %d\n', ...
            max(abs(r.vBeta)), find(abs(r.vBeta) == max(abs(r.vBeta)), 1));
        fprintf('    Effective F-stat (mean): %.2f\n', mean(r.vFstat));
    end
    
    %% LEVEL 2 - DURABLE/NONDURABLE/SERVICES
    fprintf('\nProcessing Level 2: Goods Subcategories\n');
    categories_L2 = price_log_lvl{3}.Properties.VariableNames;
    
    for i = 1:min(4, length(categories_L2))  % Just first 4 for key categories
        fprintf('  %s...\n', categories_L2{i});
        r = get_pm(price_log_lvl{3}(:,i), quant_log_lvl{3}(:,i), mps, start_date, end_date);
        field_name = sprintf('L2_%s', categories_L2{i});
        all_results.(field_name) = r;
        
        fprintf('    Phillips Multiplier peak: %.3f at month %d\n', ...
            max(abs(r.vBeta)), find(abs(r.vBeta) == max(abs(r.vBeta)), 1));
        fprintf('    Effective F-stat (mean): %.2f\n', mean(r.vFstat));
    end
    
    %% LEVEL 3 - SELECTED DETAILED CATEGORIES
    fprintf('\nProcessing Level 3: Selected Detailed Categories\n');
    categories_L3 = price_log_lvl{4}.Properties.VariableNames;
    
    % Key categories to analyze (matching LP analysis)
    key_categories = {
        'MotorVehiclesAndParts';
        'HousingAndUtilities';
        'FurnishingsAndDurableHouseholdEquipment';
        'GasolineAndOtherEnergyGoods';
        'FoodServicesAndAccommodations';
        'HealthCare';
        'TransportationServices';
        'RecreationServices';
        'ClothingAndFootwear';
        'FinancialServicesAndInsurance'
    };
    
    for k = 1:length(key_categories)
        % Find this category in the data
        cat_idx = find(strcmp(categories_L3, key_categories{k}));
        
        if isempty(cat_idx)
            fprintf('  WARNING: %s not found in data\n', key_categories{k});
            continue;
        end
        
        fprintf('  %s...\n', key_categories{k});
        r = get_pm(price_log_lvl{4}(:,cat_idx), quant_log_lvl{4}(:,cat_idx), ...
                   mps, start_date, end_date);
        field_name = sprintf('L3_%s', key_categories{k});
        all_results.(field_name) = r;
        
        % Check statistical significance using AR bounds
        pm_sig = check_pm_significance(r.vBeta, r.vLowerAR, r.vUpperAR);
        
        fprintf('    Phillips Multiplier peak: %.3f at month %d (Sig: %s)\n', ...
            max(abs(r.vBeta)), ...
            find(abs(r.vBeta) == max(abs(r.vBeta)), 1), ...
            pm_sig);
        fprintf('    Effective F-stat (mean): %.2f\n', mean(r.vFstat));
    end
    
    %% SAVE RESULTS
    output_file = 'Data/Processed/PM_Results_Summary.mat';
    save(output_file, 'all_results', '-v7.3');
    fprintf('\n✓ Saved results to: %s\n', output_file);
    
    %% CREATE READABLE SUMMARY
    fprintf('\nCreating readable summary...\n');
    create_pm_summary(all_results);
    
    fprintf('\n=== COMPLETE ===\n');
    fprintf('Use these results to populate RESULTS_ANALYSIS.md\n\n');
end

function sig_status = check_pm_significance(vBeta, vLowerAR, vUpperAR)
    % Check if AR CI excludes zero for >12 months
    excludes_zero = (vLowerAR > 0 & vUpperAR > 0) | (vLowerAR < 0 & vUpperAR < 0);
    num_sig_months = sum(excludes_zero);
    
    if num_sig_months >= 24
        sig_status = 'HIGHLY SIG (>24 mo)';
    elseif num_sig_months >= 12
        sig_status = 'SIGNIFICANT (12-24 mo)';
    else
        sig_status = 'NOT SIGNIFICANT';
    end
end

function create_pm_summary(all_results)
    % Create human-readable text summary
    
    fid = fopen('PM_Results_Summary.txt', 'w');
    fprintf(fid, '==========================================================\n');
    fprintf(fid, 'PHILLIPS MULTIPLIER RESULTS SUMMARY\n');
    fprintf(fid, '==========================================================\n\n');
    fprintf(fid, 'Sample: October 1982 - October 2008\n');
    fprintf(fid, 'Horizon: 61 months (0-60)\n');
    fprintf(fid, 'MPS: Aruoba & Drechsel (2022)\n');
    fprintf(fid, 'Method: 2SLS with AR weak-instrument robust bounds\n\n');
    
    % Get all field names
    fields = fieldnames(all_results);
    
    for i = 1:length(fields)
        r = all_results.(fields{i});
        
        fprintf(fid, '----------------------------------------------------------\n');
        fprintf(fid, '%s\n', fields{i});
        fprintf(fid, '----------------------------------------------------------\n');
        
        % Phillips Multiplier (2SLS)
        [pm_peak_val, pm_peak_idx] = max(abs(r.vBeta));
        pm_peak_sign = sign(r.vBeta(pm_peak_idx));
        fprintf(fid, 'PHILLIPS MULTIPLIER (2SLS):\n');
        fprintf(fid, '  Peak: %+.3f at month %d\n', ...
            pm_peak_sign * pm_peak_val, pm_peak_idx - 1);
        fprintf(fid, '  95%% CI (2SLS) at peak: [%.3f, %.3f]\n', ...
            r.vLowerAR2s(pm_peak_idx), ...
            r.vUpperAR2s(pm_peak_idx));
        fprintf(fid, '  95%% CI (AR robust) at peak: [%.3f, %.3f]\n', ...
            r.vLowerAR(pm_peak_idx), ...
            r.vUpperAR(pm_peak_idx));
        
        % Effective F-statistic
        fprintf(fid, '\nINSTRUMENT STRENGTH:\n');
        fprintf(fid, '  Effective F-stat (mean): %.2f\n', mean(r.vFstat));
        fprintf(fid, '  Effective F-stat (median): %.2f\n', median(r.vFstat));
        fprintf(fid, '  Effective F-stat (min): %.2f\n', min(r.vFstat));
        
        % Additional info from reduced-form IRFs
        [price_peak_val, price_peak_idx] = max(abs(r.vBetaP));
        price_peak_sign = sign(r.vBetaP(price_peak_idx));
        [quant_peak_val, quant_peak_idx] = max(abs(r.vBetaQ));
        quant_peak_sign = sign(r.vBetaQ(quant_peak_idx));
        
        fprintf(fid, '\nREDUCED-FORM IRFS:\n');
        fprintf(fid, '  Price IRF peak: %+.3fpp at month %d\n', ...
            price_peak_sign * price_peak_val, price_peak_idx - 1);
        fprintf(fid, '  Quantity IRF peak: %+.3fpp at month %d\n', ...
            quant_peak_sign * quant_peak_val, quant_peak_idx - 1);
        
        % Implied multiplier at peak response months
        fprintf(fid, '\nIMPLIED MULTIPLIER:\n');
        fprintf(fid, '  At price peak (month %d): %.3f\n', ...
            price_peak_idx - 1, r.vBeta(price_peak_idx));
        fprintf(fid, '  At quantity peak (month %d): %.3f\n', ...
            quant_peak_idx - 1, r.vBeta(quant_peak_idx));
        
        fprintf(fid, '\n');
    end
    
    fprintf(fid, '==========================================================\n');
    fprintf(fid, '\nNOTES:\n');
    fprintf(fid, '- Phillips Multiplier = dPrice/dQuantity in response to MPS\n');
    fprintf(fid, '- Positive PM: Prices and quantities move in same direction\n');
    fprintf(fid, '- Negative PM: Prices and quantities move in opposite directions\n');
    fprintf(fid, '- AR bounds are weak-instrument robust (use when F-stat < 10)\n');
    fprintf(fid, '- Effective F-stat measures instrument strength at each horizon\n');
    fprintf(fid, '==========================================================\n');
    fclose(fid);
    
    fprintf('✓ Created PM_Results_Summary.txt\n');
end
