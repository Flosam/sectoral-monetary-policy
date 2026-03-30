function run_all(get_func, plot_func, price, quant, mps, start_date, end_date, save)
    % RUN_ALL - Execute analysis across all hierarchical disaggregation levels
    %
    % Runs the specified analysis function (Local Projection or Phillips Multiplier)
    % across all 7 hierarchical levels of PCE disaggregation and generates plots.
    %
    % Inputs:
    %   get_func - Function handle to analysis function (@get_lp or @get_pm)
    %   plot_func - Function handle to plotting function (@plot_lp or @plot_irfs)
    %   price - 7x1 cell array of price data by level (from import_pce_data)
    %   quant - 7x1 cell array of quantity data by level
    %   mps - Timetable of monetary policy shocks
    %   start_date - Analysis start date (string or datetime)
    %   end_date - Analysis end date (string or datetime)
    %   save - Boolean flag to save figures
    %
    % Example:
    %   run_all(@get_lp, @plot_lp, price_log_lvl, quant_log_lvl, ...
    %           mps_ad, '1982-01-01', '2008-01-01', true);
    %
    % Note: Processes levels 0-3 (aggregate through 3rd disaggregation level).
    %       Levels 4-6 can be added by extending the loop range.
    
    fprintf('Running analysis across hierarchical levels...\n');
    
    % Level 0 (Aggregate PCE)
    fprintf('  Processing Level 0 (Aggregate)...\n');
    r0 = get_func(price{1}, quant{1}, mps, start_date, end_date);
    plot_func(r0, 'Aggregate PCE', save);
    
    % Levels 1-3 (Loop through all categories at each level)
    for l = 2:4
        numCategories = size(price{l}, 2);
        fprintf('  Processing Level %d (%d categories)...\n', l-1, numCategories);
        
        for i = 1:numCategories
            p = price{l}(:, i);
            q = quant{l}(:, i);
            r = get_func(p, q, mps, start_date, end_date);
            
            name = sprintf('Lvl %d - %s', l-1, price{l}.Properties.VariableNames{i});
            plot_func(r, name, save);
        end
    end
    
    fprintf('Analysis complete!\n');
end
