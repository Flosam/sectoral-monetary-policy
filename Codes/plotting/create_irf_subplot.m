function create_irf_subplot(x, vBeta, vLower, vUpper, subplotPos, yLabel, titleText)
    % CREATE_IRF_SUBPLOT - Create standardized impulse response subplot
    %
    % Creates a subplot with shaded confidence intervals for impulse response
    % functions, following consistent formatting.
    %
    % Inputs:
    %   x - Horizons (x-axis values)
    %   vBeta - Point estimates (IRF coefficients)
    %   vLower - Lower confidence bound
    %   vUpper - Upper confidence bound
    %   subplotPos - Subplot position (e.g., 211 for top panel)
    %   yLabel - Y-axis label text
    %   titleText - (Optional) Subplot title
    %
    % Example:
    %   create_irf_subplot(1:61, beta, lower, upper, 211, 'Price', 'Price Response');
    
    iH = length(vBeta);
    
    % Calculate errors for shaded region
    % Ensure vectors are column vectors, then transpose for shadedErrorBar
    vBeta = vBeta(:);  % Ensure column vector
    vLower = vLower(:);  % Ensure column vector
    vUpper = vUpper(:);  % Ensure column vector
    
    error1 = abs(vBeta - vLower);  % Lower error (below the line)
    error2 = abs(vUpper - vBeta);  % Upper error (above the line)
    
    % shadedErrorBar expects [2 x N] matrix where row 1 = upper, row 2 = lower
    errBarMatrix = [error2'; error1'];
    
    % Create subplot
    sbp = subplot(subplotPos);
    hold on;
    
    % Plot zero line
    plot(x, 0*vBeta, 'LineWidth', 1, 'Color', [.7 .7 .7], 'LineStyle', '--');
    
    % Plot shaded error bar
    shadedErrorBar(x, vBeta, errBarMatrix, 'k', 0, 1);
    
    % Plot main line
    plot(vBeta, 'Linewidth', 2, 'Color', 'k', 'LineStyle', '-');
    
    % Labels and formatting
    ylabel(yLabel, 'Interpreter', 'latex', 'Fontsize', 14);
    xlabel('Months', 'Interpreter', 'latex');
    
    % X-axis settings
    xlim([1 iH]);
    set(gca, 'Xtick', 1:5:iH);
    set(gca, 'Xticklabel', num2str((0:5:iH)'));
    
    % Y-axis formatting
    ytickformat('percentage');
    
    % Optional title
    if nargin > 6 && ~isempty(titleText)
        title(titleText, 'Interpreter', 'latex');
    end
    
    hold off;
end
