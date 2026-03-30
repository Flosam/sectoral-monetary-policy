%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT_IRFS - Plot Phillips Multiplier impulse response functions
%
% Creates a 4-panel figure showing:
%   1. Phillips Multiplier with AR confidence bounds
%   2. Quantity impulse response (normalized)
%   3. F-statistic for instrument strength
%   4. Price impulse response (normalized)
%
% Created by: Florent Samson
% Last modified: 2025/02/20
% 
% Reference:
%   Methodology from Geert Mesters
%   https://www.openicpsr.org/openicpsr/project/114114/version/V1/view 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plot_irfs(results, figureTitle, saveFigure)
    % PLOT_IRFS - Plot Phillips Multiplier results
    %
    % Inputs:
    %   results - Structure from get_pm() with all PM estimates and bounds
    %   figureTitle - Title for the figure
    %   saveFigure - (Optional, false default) If true, save to Data/Figures/
    %
    % Example:
    %   plot_irfs(results, 'Aggregate PCE', true);
    
    % Load configuration
    config = ProjectConfig.get();
    
    % Extract data
    vBeta = results.vBeta;
    vUpperAR = results.vUpperAR;
    vLowerAR = results.vLowerAR;
    vLowerAR2s = results.vLowerAR2s;
    vUpperAR2s = results.vUpperAR2s;
    vBetaQ = results.vBetaQ;
    vUpperQ = results.vUpperQ;
    vLowerQ = results.vLowerQ;
    vBetaP = results.vBetaP;
    vUpperP = results.vUpperP;
    vLowerP = results.vLowerP;
    vFstat = results.vFstat;
    iH = results.iH;
    
    % Create horizons vector
    x = (1:iH)';
    
    % Create figure
    figure;
    
    % ===== Panel 3: F-statistic (bottom left) =====
    subplot(223);
    hold on;
    bar(x, vFstat)
    ylabel('F-stat', 'Interpreter', 'latex')
    xlabel('Months', 'Interpreter', 'latex');
    xlim([1 iH]);
    ylim([0 12]);
    set(gca, 'Xtick', 1:5:iH);
    set(gca, 'Xticklabel', num2str((0:5:iH)'));
    hold off;
    
    % ===== Panel 1: Phillips Multiplier (top left) =====
    subplot(221);
    hold on;
    
    % Zero line
    plot(x, 0*vBeta, 'LineWidth', 1, 'Color', [.7 .7 .7], 'LineStyle', '--');
    
    % AR confidence bounds (shaded)
    error1 = abs(vBeta - vLowerAR);
    error2 = abs(vBeta - vUpperAR);
    shadedErrorBar(x, vBeta, [error2; error1], 'k', 0, 1);
    
    % Point estimate
    plot(vBeta, 'Linewidth', 2, 'Color', 'k', 'LineStyle', '-');
    
    % 2SLS confidence bounds (dotted lines)
    plot(vLowerAR2s, 'Linewidth', 1, 'Color', 'k', 'LineStyle', ':');
    plot(vUpperAR2s, 'Linewidth', 1, 'Color', 'k', 'LineStyle', ':');
    
    ylabel('$\mathcal{P}_h$', 'Interpreter', 'latex', 'Fontsize', 14)
    ylim([-5 5]);
    xlim([1 iH]);
    set(gca, 'Xticklabel', num2str((0:5:iH)'));
    set(gca, 'Xtick', 1:5:iH);
    set(gca, 'Ytick', -14:2:14);
    title('Phillips multiplier', 'Interpreter', 'latex');
    hold off;
    
    % ===== Rescale IRFs so quantity peaks at 1 =====
    [ir, irub, irlb] = rescale_irf([vBetaQ vBetaP], [vUpperQ vUpperP], ...
                                    [vLowerQ vLowerP]);
    
    % Calculate errors for shaded regions
    error1 = abs(ir - irlb);
    error2 = abs(ir - irub);
    
    % ===== Panels 2 & 4: Quantity and Price IRFs =====
    irfLabels = {'{$\mathcal R^{\bar q}_h$}', '{$\mathcal R^{\bar p}_h$}'};
    irfTitles = {'Impulse Responses', ''};
    subplotPositions = [222, 224];
    
    for ii = 1:2
        subplot(2, 2, subplotPositions(ii));
        hold on;
        
        % Zero line
        plot(x, 0*ir(:,ii), 'LineWidth', 1, 'Color', [.7 .7 .7], 'LineStyle', '--');
        
        % Shaded confidence interval
        shadedErrorBar(x, ir(:,ii), [error2(:,ii); error1(:,ii)], 'k', 0, 1);
        
        % Point estimate
        plot(ir(:,ii), 'Linewidth', 2, 'Color', 'k', 'LineStyle', '-');
        
        % Labels
        ylabel(irfLabels{ii}, 'Interpreter', 'latex', 'Fontsize', 14);
        if ii == 2
            xlabel('Months', 'Interpreter', 'latex');
        end
        
        % Title for first panel
        if ~isempty(irfTitles{ii})
            title(irfTitles{ii}, 'Interpreter', 'latex');
        end
        
        % Axis settings
        ylim([-2 2]);
        xlim([1 iH]);
        set(gca, 'Xticklabel', num2str((0:5:iH)'));
        set(gca, 'Xtick', 1:5:iH);
        
        if ii == 2
            set(gca, 'Ytick', -10:1:1);
        else
            set(gca, 'Ytick', -10:1:10);
        end
        
        hold off;
    end
    
    % Overall title (remove colons for filename compatibility)
    figureTitle = strrep(figureTitle, ':', '');
    
    % Save figure if requested
    if nargin > 2 && saveFigure == true
        % Ensure output directory exists
        outputDir = fullfile(config.FIGURES_DIR, 'Philips_Multiplier');
        ensure_dir(outputDir);
        
        % Save figure
        filename = fullfile(outputDir, [figureTitle, '.png']);
        saveas(gcf, filename);
        fprintf('Figure saved to: %s\n', filename);
    end
end