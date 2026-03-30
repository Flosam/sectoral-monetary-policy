function extract_key_results()
    % EXTRACT_KEY_RESULTS - Extract and summarize key findings from LP analysis
    %
    % This script loads the generated results and extracts key statistics
    % for the RESULTS_ANALYSIS.md document, focusing on:
    % 1. Aggregate and major category responses
    % 2. Categories with statistically significant IRFs
    % 3. Phillips Multiplier estimates
    %
    % Outputs:
    %   Creates results_summary.txt with formatted statistics
    %   Displays findings in command window
    
    fprintf('\n=== EXTRACTING KEY RESULTS FROM LOCAL PROJECTIONS ANALYSIS ===\n\n');
    
    % Load configuration
    config = ProjectConfig.get();
    
    % Initialize results storage
    results_summary = struct();
    
    %% 1. AGGREGATE RESULTS (Level 0)
    fprintf('1. AGGREGATE PCE RESULTS\n');
    fprintf('----------------------------------------\n');
    
    % Note: You'll need to re-run main.m with save=true to get stored results
    % For now, we'll create a template for manual filling
    
    fprintf('To populate results, run main.m and inspect figures:\n');
    fprintf('  - Data/Figures/Local_Projections/Aggregate PCE.png\n');
    fprintf('  - Data/Figures/Philips_Multiplier/Aggregate PCE.png\n\n');
    
    %% 2. LEVEL 1 RESULTS (Goods vs Services)
    fprintf('2. MAJOR CATEGORY COMPARISON\n');
    fprintf('----------------------------------------\n');
    
    categories_L1 = {'Goods', 'Services'};
    
    for i = 1:length(categories_L1)
        fprintf('\n%s:\n', categories_L1{i});
        fprintf('  Figure: Data/Figures/Local_Projections/Lvl 1 - %s.png\n', ...
            categories_L1{i});
        fprintf('  [TODO: Inspect figure and record]\n');
        fprintf('    - Peak price response: ___ %% at ___ months\n');
        fprintf('    - Peak quantity response: ___ %% at ___ months\n');
        fprintf('    - Statistical significance: YES/NO\n');
    end
    
    %% 3. LEVEL 2 RESULTS (Durable/Nondurable/Services)
    fprintf('\n\n3. GOODS SUBCATEGORIES\n');
    fprintf('----------------------------------------\n');
    
    categories_L2 = {'DurableGoods', 'NondurableGoods', ...
        'HouseholdConsumptionExpenditures_forServices_'};
    category_names_L2 = {'Durable Goods', 'Nondurable Goods', 'Services'};
    
    for i = 1:length(categories_L2)
        fprintf('\n%s:\n', category_names_L2{i});
        fprintf('  Figure: Data/Figures/Local_Projections/Lvl 2 - %s.png\n', ...
            categories_L2{i});
        fprintf('  [TODO: Record key statistics]\n');
    end
    
    %% 4. LEVEL 3 - IDENTIFY SIGNIFICANT CATEGORIES
    fprintf('\n\n4. DETAILED CATEGORIES WITH SIGNIFICANT IRFs\n');
    fprintf('===========================================\n');
    
    % List of Level 3 categories to examine
    categories_L3 = {
        'MotorVehiclesAndParts', 'Motor Vehicles and Parts';
        'HousingAndUtilities', 'Housing and Utilities';
        'FurnishingsAndDurableHouseholdEquipment', 'Furnishings & Durable Equipment';
        'GasolineAndOtherEnergyGoods', 'Gasoline and Energy Goods';
        'FoodServicesAndAccommodations', 'Food Services & Accommodations';
        'RecreationServices', 'Recreation Services';
        'TransportationServices', 'Transportation Services';
        'HealthCare', 'Health Care';
        'FoodAndBeveragesPurchasedForOff_premisesConsumption', 'Food & Beverages (Off-Premises)';
        'ClothingAndFootwear', 'Clothing and Footwear';
        'FinancialServicesAndInsurance', 'Financial Services & Insurance';
        'RecreationalGoodsAndVehicles', 'Recreational Goods & Vehicles';
        'OtherServices', 'Other Services'
    };
    
    fprintf('\nCategories to examine for statistical significance:\n\n');
    
    for i = 1:size(categories_L3, 1)
        fprintf('%d. %s\n', i, categories_L3{i, 2});
        fprintf('   File: Lvl 3 - %s.png\n', categories_L3{i, 1});
        fprintf('   Check: Do confidence intervals exclude zero for >12 months?\n');
        fprintf('   Price: YES/NO  |  Quantity: YES/NO\n\n');
    end
    
    %% 5. CATEGORIZATION GUIDELINES
    fprintf('\n\n5. CATEGORIZATION CRITERIA\n');
    fprintf('===========================================\n\n');
    
    fprintf('When examining figures, classify as:\n\n');
    
    fprintf('HIGHLY RESPONSIVE:\n');
    fprintf('  - Confidence intervals exclude zero for >24 months\n');
    fprintf('  - Peak magnitude >1%% for prices OR >2%% for quantities\n');
    fprintf('  - Examples: Motor vehicles, durables, energy goods\n\n');
    
    fprintf('MODERATELY RESPONSIVE:\n');
    fprintf('  - Confidence intervals exclude zero for 12-24 months\n');
    fprintf('  - Peak magnitude 0.5-1%% for prices OR 1-2%% for quantities\n');
    fprintf('  - Examples: Food services, recreation, transportation\n\n');
    
    fprintf('UNRESPONSIVE/INSIGNIFICANT:\n');
    fprintf('  - Confidence intervals include zero throughout horizon\n');
    fprintf('  - No clear pattern in point estimates\n');
    fprintf('  - Examples: Health care (typically), utilities\n\n');
    
    %% 6. PHILLIPS MULTIPLIER SUMMARY
    fprintf('\n6. PHILLIPS MULTIPLIER ANALYSIS\n');
    fprintf('===========================================\n\n');
    
    fprintf('For each category, record from Phillips Multiplier figures:\n');
    fprintf('  1. Point estimate (horizontal line level)\n');
    fprintf('  2. Confidence interval (shaded region)\n');
    fprintf('  3. Whether CI excludes zero (statistically significant)\n');
    fprintf('  4. First-stage F-statistic (check for weak instruments)\n\n');
    
    fprintf('Categories to prioritize:\n');
    fprintf('  - Aggregate PCE\n');
    fprintf('  - Goods vs Services\n');
    fprintf('  - Durable vs Nondurable\n');
    fprintf('  - Any Level 3 category with significant LP responses\n\n');
    
    %% 7. CREATE ANALYSIS WORKFLOW
    fprintf('\n7. RECOMMENDED WORKFLOW\n');
    fprintf('===========================================\n\n');
    
    fprintf('Step 1: Examine figures systematically\n');
    fprintf('  - Start with Aggregate PCE\n');
    fprintf('  - Move to Level 1 (Goods vs Services)\n');
    fprintf('  - Then Level 2 (Durable/Nondurable/Services breakdown)\n');
    fprintf('  - Finally Level 3 (focus on significant categories)\n\n');
    
    fprintf('Step 2: For each figure, record:\n');
    fprintf('  a) Peak price response (magnitude and timing)\n');
    fprintf('  b) Peak quantity response (magnitude and timing)\n');
    fprintf('  c) Statistical significance (CI excludes zero?)\n');
    fprintf('  d) Persistence (how long does response last?)\n\n');
    
    fprintf('Step 3: Fill in RESULTS_ANALYSIS.md\n');
    fprintf('  - Replace [DESCRIBE] placeholders with actual findings\n');
    fprintf('  - Replace [X.XX] with numerical estimates\n');
    fprintf('  - Replace [YES/NO] with definitive answers\n');
    fprintf('  - Add interpretation based on economic theory\n\n');
    
    fprintf('Step 4: Identify patterns\n');
    fprintf('  - Compare durable vs nondurable responses\n');
    fprintf('  - Assess price stickiness (magnitude of price vs quantity)\n');
    fprintf('  - Evaluate monetary policy transmission channels\n');
    fprintf('  - Test economic hypotheses (e.g., interest sensitivity)\n\n');
    
    %% 8. CREATE SUMMARY TABLE TEMPLATE
    fprintf('\n8. CREATING SUMMARY TABLE TEMPLATE\n');
    fprintf('===========================================\n\n');
    
    % Create a template CSV for manual data entry
    summary_table = table();
    summary_table.Category = categories_L3(:, 2);
    summary_table.Level = repmat("3", size(categories_L3, 1), 1);
    summary_table.PeakPriceResp_Pct = nan(size(categories_L3, 1), 1);
    summary_table.PricePeak_Month = nan(size(categories_L3, 1), 1);
    summary_table.PriceSig = repmat("", size(categories_L3, 1), 1);
    summary_table.PeakQuantityResp_Pct = nan(size(categories_L3, 1), 1);
    summary_table.QuantityPeak_Month = nan(size(categories_L3, 1), 1);
    summary_table.QuantitySig = repmat("", size(categories_L3, 1), 1);
    summary_table.PhillipsMultiplier = nan(size(categories_L3, 1), 1);
    summary_table.PM_CI_Lower = nan(size(categories_L3, 1), 1);
    summary_table.PM_CI_Upper = nan(size(categories_L3, 1), 1);
    
    % Save template
    output_file = 'results_summary_template.csv';
    writetable(summary_table, output_file);
    fprintf('Created template: %s\n', output_file);
    fprintf('Fill this in as you examine figures, then use for analysis.\n\n');
    
    %% 9. EXPORT INSTRUCTIONS
    fprintf('\n9. FINAL STEPS\n');
    fprintf('===========================================\n\n');
    
    fprintf('After filling in results:\n');
    fprintf('  1. Complete RESULTS_ANALYSIS.md with all findings\n');
    fprintf('  2. Add date and commit hash at bottom\n');
    fprintf('  3. Create summary figures (optional):\n');
    fprintf('     - Heatmap of sectoral responses\n');
    fprintf('     - Bar chart of Phillips Multipliers\n');
    fprintf('     - Timeline showing peak impact by sector\n');
    fprintf('  4. Commit to GitHub with message:\n');
    fprintf('     "Add comprehensive results analysis"\n\n');
    
    fprintf('=== EXTRACTION COMPLETE ===\n\n');
    fprintf('Next: Examine figures in Data/Figures/ and populate RESULTS_ANALYSIS.md\n\n');
end
