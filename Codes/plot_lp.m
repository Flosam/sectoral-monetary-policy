function plot_lp(results, figureTitle, saveFigure)
    % PLOT_LP - Plot local projection impulse response functions
    %
    % Creates a two-panel figure showing price and quantity impulse responses
    % to a monetary policy shock, with shaded confidence intervals.
    %
    % Inputs:
    %   results - Structure from get_lp() with fields:
    %             .price.vBeta, .price.vLower, .price.vUpper
    %             .quant.vBeta, .quant.vLower, .quant.vUpper
    %   figureTitle - Title for the figure
    %   saveFigure - (Optional, false default) If true, save figure to Data/Figures/
    %
    % Example:
    %   plot_lp(results, 'Aggregate PCE', true);
    
    % Load configuration
    config = ProjectConfig.get();
    
    % Extract results
    vBetaP = results.price.vBeta;
    vBetaQ = results.quant.vBeta;
    vLowerP = results.price.vLower;
    vUpperP = results.price.vUpper;
    vLowerQ = results.quant.vLower;
    vUpperQ = results.quant.vUpper;
    
    % Create x-axis (horizons)
    iH = length(vBetaP);
    x = (1:iH)';
    
    % Create figure
    f = figure;
    
    % Plot quantity response (top panel)
    create_irf_subplot(x, vBetaQ, vLowerQ, vUpperQ, 211, 'Quantity', '');
    
    % Plot price response (bottom panel)
    create_irf_subplot(x, vBetaP, vLowerP, vUpperP, 212, 'Price', '');
    
    % Add overall title (remove colons for filename compatibility)
    figureTitle = strrep(figureTitle, ':', '');
    sgtitle(figureTitle, 'Interpreter', 'latex');
    
    % Save figure if requested
    if nargin > 2 && saveFigure == true
        % Ensure output directory exists
        outputDir = fullfile(config.FIGURES_DIR, 'Local_Projections');
        ensure_dir(outputDir);
        
        % Save figure
        filename = fullfile(outputDir, [figureTitle, '.png']);
        saveas(f, filename);
        fprintf('Figure saved to: %s\n', filename);
    end
end