function varargout = shadedErrorBar(x, y, errBar, lineProps, transparent, shadeIntensity)
    % SHADEDERRORBAR - Create line plot with shaded error bars
    %
    % Makes a 2-D line plot with a shaded error bar using patch.
    % Error bar color is chosen automatically based on line color.
    %
    % Inputs:
    %   x - Vector of x values (optional, can be left empty to use indices)
    %   y - Vector of y values or matrix of n observations by m cases
    %   errBar - Error specification:
    %            - Vector: symmetric error bars
    %            - [2 x length(x)] matrix: asymmetric bars (row 1 = upper, row 2 = lower)
    %            - Cell array of function handles: {statistic_func, error_func}
    %   lineProps - (Optional, '-k' default) Line properties
    %               Examples: 'or-' or {'-or','markerfacecolor',[1,0.2,0.2]}
    %   transparent - (Optional, 0 default) If 1, uses transparency (requires OpenGL)
    %   shadeIntensity - (Optional, 1 default) Controls shade darkness (1=normal, 2=lighter)
    %
    % Outputs:
    %   H - Structure of handles:
    %       .mainLine - Handle to main line
    %       .patch - Handle to shaded patch
    %
    % Examples:
    %   % Symmetric error bars
    %   shadedErrorBar(1:100, mean(data), std(data), 'k');
    %
    %   % Asymmetric error bars
    %   shadedErrorBar(x, y, [upperErr; lowerErr], '-b');
    %
    %   % Using function handles for dynamic computation
    %   shadedErrorBar(x, data, {@median, @std}, {'r-o','markerfacecolor','r'});
    %
    %   % Lighter shade
    %   shadedErrorBar(x, y, err, 'k', 0, 2);
    %
    % Note: Modified version (RB) with shadeIntensity parameter for lighter shading.
    %       Used in this project for plotting impulse response functions.
    %
    % Original author: Rob Campbell - November 2009
    % Modified by: RB (added shadeIntensity parameter)
    
    % Error checking
    error(nargchk(3, 6, nargin))
    
    % Set default shade intensity
    if nargin < 6 || isempty(shadeIntensity)
        shadeIntensity = 1;
    end
    
    % Process y using function handles if needed
    if iscell(errBar)
        fun1 = errBar{1};
        fun2 = errBar{2};
        errBar = fun2(y);
        y = fun1(y);
    else
        y = y(:)';
    end
    
    % Set x values if empty
    if isempty(x)
        x = 1:length(y);
    else
        x = x(:)';
    end
    
    % Make upper and lower error bars if only one was specified
    if length(errBar) == length(errBar(:))
        errBar = repmat(errBar(:)', 2, 1);
    else
        s = size(errBar);
        f = find(s == 2);
        if isempty(f)
            error('shadedErrorBar:InvalidSize', 'errBar has the wrong size');
        end
        if f == 2
            errBar = errBar';
        end
    end
    
    % Validate dimensions
    if length(x) ~= length(errBar)
        error('shadedErrorBar:DimensionMismatch', 'length(x) must equal length(errBar)');
    end
    
    % Set default line properties
    defaultProps = {'-k'};
    if nargin < 4, lineProps = defaultProps; end
    if isempty(lineProps), lineProps = defaultProps; end
    if ~iscell(lineProps), lineProps = {lineProps}; end
    
    if nargin < 5, transparent = 0; end
    
    % Plot main line to get color parameters
    H.mainLine = plot(x, y, lineProps{:});
    
    % Determine shaded region color
    col = get(H.mainLine, 'color');
    edgeColor = col + (1 - col) * 0.55;
    
    % Adjust patch saturation based on shadeIntensity
    patchSaturation = 0.15 * shadeIntensity;
    
    if transparent
        faceAlpha = patchSaturation;
        patchColor = col;
        set(gcf, 'renderer', 'openGL')
    else
        faceAlpha = 1;
        patchColor = col + (1 - col) * (1 - patchSaturation);
        set(gcf, 'renderer', 'painters')
    end
    
    % Calculate error bars
    uE = y + errBar(1, :);
    lE = y - errBar(2, :);
    
    % Preserve hold status
    holdStatus = ishold;
    if ~holdStatus, hold on, end
    
    % Create patch coordinates
    yP = [lE, fliplr(uE)];
    xP = [x, fliplr(x)];
    
    % Remove NaNs (patch won't work with NaNs)
    xP(isnan(yP)) = [];
    yP(isnan(yP)) = [];
    
    % Create shaded patch
    H.patch = patch(xP, yP, 1, 'facecolor', patchColor, ...
        'edgecolor', 'none', ...
        'facealpha', faceAlpha);
    
    % Redraw main line on top
    delete(H.mainLine)
    H.mainLine = plot(x, y, lineProps{:});
    
    % Restore hold status
    if ~holdStatus, hold off, end
    
    % Return handles if requested
    if nargout == 1
        varargout{1} = H;
    end
end
