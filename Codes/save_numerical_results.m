function save_numerical_results()
    % SAVE_NUMERICAL_RESULTS - Re-run analysis and save numerical estimates
    %
    % This script re-runs the Local Projection analysis for key categories
    % and saves the numerical IRF estimates (betas and confidence intervals)
    % so they can be used to populate RESULTS_ANALYSIS.md
    %
    % Output: Creates 'LP_Results_Summary.mat' with all numerical estimates
    
    fprintf('\n=== SAVING NUMERICAL RESULTS ===\n\n');
    
    % Initialize paths and load data
    run('paths/initialize_paths.m');
    config = ProjectConfig.get();
    
    % Load processed data
    fprintf('Loading processed data...\n');
    load(config.QUANTITY_INDEX_FILE, 'quant_gr_lvl');  % Growth rates for LP
    load(config.PRICE_INDEX_FILE, 'price_gr_lvl');    % Growth rates for LP
    load(config.MPS_FILE, 'mps_ad');
    
    % Use Aruoba & Drechsel MPS (1982-2008)
    mps = mps_ad;
    start_date = '1982-10-01';
    end_date = '2008-10-01';
    
    % Initialize results storage
    all_results = struct();
    
    %% LEVEL 0 - AGGREGATE
    fprintf('\nProcessing Level 0: Aggregate PCE\n');
    r = get_lp(price_gr_lvl{1}, quant_gr_lvl{1}, mps, start_date, end_date);
    all_results.L0_Aggregate = r;
    
    % Extract key statistics
    fprintf('  Price peak: %.3fpp at month %d\n', ...
        max(abs(r.price.vBeta)), find(abs(r.price.vBeta) == max(abs(r.price.vBeta)), 1));
    fprintf('  Quantity peak: %.3fpp at month %d\n', ...
        max(abs(r.quant.vBeta)), find(abs(r.quant.vBeta) == max(abs(r.quant.vBeta)), 1));
    
    %% LEVEL 1 - GOODS VS SERVICES
    fprintf('\nProcessing Level 1: Major Categories\n');
    categories_L1 = price_gr_lvl{2}.Properties.VariableNames;
    
    for i = 1:length(categories_L1)
        fprintf('  %s...\n', categories_L1{i});
        r = get_lp(price_gr_lvl{2}(:,i), quant_gr_lvl{2}(:,i), mps, start_date, end_date);
        field_name = sprintf('L1_%s', categories_L1{i});
        all_results.(field_name) = r;
        
        fprintf('    Price peak: %.3fpp at month %d\n', ...
            max(abs(r.price.vBeta)), find(abs(r.price.vBeta) == max(abs(r.price.vBeta)), 1));
        fprintf('    Quantity peak: %.3fpp at month %d\n', ...
            max(abs(r.quant.vBeta)), find(abs(r.quant.vBeta) == max(abs(r.quant.vBeta)), 1));
    end
    
    %% LEVEL 2 - DURABLE/NONDURABLE/SERVICES
    fprintf('\nProcessing Level 2: Goods Subcategories\n');
    categories_L2 = price_gr_lvl{3}.Properties.VariableNames;
    
    for i = 1:min(4, length(categories_L2))  % Just first 4 for key categories
        fprintf('  %s...\n', categories_L2{i});
        r = get_lp(price_gr_lvl{3}(:,i), quant_gr_lvl{3}(:,i), mps, start_date, end_date);
        field_name = sprintf('L2_%s', categories_L2{i});
        all_results.(field_name) = r;
        
        fprintf('    Price peak: %.3fpp at month %d\n', ...
            max(abs(r.price.vBeta)), find(abs(r.price.vBeta) == max(abs(r.price.vBeta)), 1));
        fprintf('    Quantity peak: %.3fpp at month %d\n', ...
            max(abs(r.quant.vBeta)), find(abs(r.quant.vBeta) == max(abs(r.quant.vBeta)), 1));
    end
    
    %% LEVEL 3 - SELECTED DETAILED CATEGORIES
    fprintf('\nProcessing Level 3: Selected Detailed Categories\n');
    categories_L3 = price_gr_lvl{4}.Properties.VariableNames;
    
    % Key categories to analyze
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
        r = get_lp(price_gr_lvl{4}(:,cat_idx), quant_gr_lvl{4}(:,cat_idx), ...
                   mps, start_date, end_date);
        field_name = sprintf('L3_%s', key_categories{k});
        all_results.(field_name) = r;
        
        % Check statistical significance
        price_sig = check_significance(r.price.vBeta, r.price.vLower, r.price.vUpper);
        quant_sig = check_significance(r.quant.vBeta, r.quant.vLower, r.quant.vUpper);
        
        fprintf('    Price peak: %.3fpp at month %d (Sig: %s)\n', ...
            max(abs(r.price.vBeta)), ...
            find(abs(r.price.vBeta) == max(abs(r.price.vBeta)), 1), ...
            price_sig);
        fprintf('    Quantity peak: %.3fpp at month %d (Sig: %s)\n', ...
            max(abs(r.quant.vBeta)), ...
            find(abs(r.quant.vBeta) == max(abs(r.quant.vBeta)), 1), ...
            quant_sig);
    end
    
    %% SAVE RESULTS
    output_file = 'Data/Processed/LP_Results_Summary.mat';
    save(output_file, 'all_results', '-v7.3');
    fprintf('\n✓ Saved results to: %s\n', output_file);
    
    %% CREATE READABLE SUMMARY
    fprintf('\nCreating readable summary...\n');
    create_results_summary(all_results);
    
    fprintf('\n=== COMPLETE ===\n');
    fprintf('Use these results to populate RESULTS_ANALYSIS.md\n\n');
end

function sig_status = check_significance(vBeta, vLower, vUpper)
    % Check if CI excludes zero for >12 months
    excludes_zero = (vLower > 0 & vUpper > 0) | (vLower < 0 & vUpper < 0);
    num_sig_months = sum(excludes_zero);
    
    if num_sig_months >= 24
        sig_status = 'HIGHLY SIG (>24 mo)';
    elseif num_sig_months >= 12
        sig_status = 'SIGNIFICANT (12-24 mo)';
    else
        sig_status = 'NOT SIGNIFICANT';
    end
end

function create_results_summary(all_results)
    % Create human-readable text summary
    
    fid = fopen('LP_Results_Summary.txt', 'w');
    fprintf(fid, '==========================================================\n');
    fprintf(fid, 'LOCAL PROJECTIONS RESULTS SUMMARY\n');
    fprintf(fid, '==========================================================\n\n');
    fprintf(fid, 'Sample: October 1982 - October 2008\n');
    fprintf(fid, 'Horizon: 61 months (0-60)\n');
    fprintf(fid, 'MPS: Aruoba & Drechsel (2022)\n\n');
    
    % Get all field names
    fields = fieldnames(all_results);
    
    for i = 1:length(fields)
        r = all_results.(fields{i});
        
        fprintf(fid, '----------------------------------------------------------\n');
        fprintf(fid, '%s\n', fields{i});
        fprintf(fid, '----------------------------------------------------------\n');
        
        % Price response
        [price_peak_val, price_peak_idx] = max(abs(r.price.vBeta));
        price_peak_sign = sign(r.price.vBeta(price_peak_idx));
        fprintf(fid, 'PRICE RESPONSE:\n');
        fprintf(fid, '  Peak: %+.3fpp at month %d\n', ...
            price_peak_sign * price_peak_val, price_peak_idx - 1);
        fprintf(fid, '  95%% CI at peak: [%.3f, %.3f]\n', ...
            r.price.vLower(price_peak_idx), ...
            r.price.vUpper(price_peak_idx));
        
        % Quantity response
        [quant_peak_val, quant_peak_idx] = max(abs(r.quant.vBeta));
        quant_peak_sign = sign(r.quant.vBeta(quant_peak_idx));
        fprintf(fid, '\nQUANTITY RESPONSE:\n');
        fprintf(fid, '  Peak: %+.3fpp at month %d\n', ...
            quant_peak_sign * quant_peak_val, quant_peak_idx - 1);
        fprintf(fid, '  95%% CI at peak: [%.3f, %.3f]\n', ...
            r.quant.vLower(quant_peak_idx), ...
            r.quant.vUpper(quant_peak_idx));
        
        fprintf(fid, '\n');
    end
    
    fprintf(fid, '==========================================================\n');
    fclose(fid);
    
    fprintf('✓ Created LP_Results_Summary.txt\n');
end


