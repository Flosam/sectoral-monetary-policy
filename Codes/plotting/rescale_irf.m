function [ir_scaled, irub_scaled, irlb_scaled] = rescale_irf(vBeta, vUpper, vLower, scaleFactor)
    % RESCALE_IRF - Rescale impulse response and confidence bounds
    %
    % Rescales impulse response functions so that a specific variable
    % (typically quantity) peaks at a normalized value (e.g., 1).
    %
    % Inputs:
    %   vBeta - Point estimate vector(s) (can be matrix with multiple IRFs)
    %   vUpper - Upper confidence bound(s)
    %   vLower - Lower confidence bound(s)
    %   scaleFactor - (Optional) Custom scale factor. If not provided,
    %                 scales by max absolute value of first column
    %
    % Outputs:
    %   ir_scaled - Rescaled point estimates
    %   irub_scaled - Rescaled upper bounds
    %   irlb_scaled - Rescaled lower bounds
    %
    % Example:
    %   % Scale so quantity IRF peaks at 1
    %   [ir, irub, irlb] = rescale_irf([vBetaQ vBetaP], [vUpperQ vUpperP], ...
    %                                   [vLowerQ vLowerP]);
    %
    % Note: This is useful for comparing price and quantity responses on
    %       the same scale when the quantity response is normalized to 1.
    
    % Determine scale factor if not provided
    if nargin < 4 || isempty(scaleFactor)
        % Scale by maximum absolute value of first column (typically quantity)
        scaleFactor = max(abs(vBeta(:, 1)));
    end
    
    % Validate scale factor
    if scaleFactor == 0
        warning('rescale_irf:ZeroScale', ...
            'Scale factor is zero. Returning original values.');
        ir_scaled = vBeta;
        irub_scaled = vUpper;
        irlb_scaled = vLower;
        return;
    end
    
    % Rescale all values
    ir_scaled = vBeta / scaleFactor;
    irub_scaled = vUpper / scaleFactor;
    irlb_scaled = vLower / scaleFactor;
end
