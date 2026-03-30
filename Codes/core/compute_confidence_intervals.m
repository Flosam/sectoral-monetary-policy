function [lowerBound, upperBound] = compute_confidence_intervals(beta, residuals, regressor, confidenceLevel, numLags)
    % COMPUTE_CONFIDENCE_INTERVALS - Calculate confidence intervals using Newey-West HAC covariance
    %
    % Computes heteroskedasticity and autocorrelation consistent (HAC) standard
    % errors using the Newey-West estimator, then constructs confidence intervals.
    %
    % Inputs:
    %   beta - Point estimate (scalar or vector)
    %   residuals - n x 1 vector of regression residuals
    %   regressor - n x 1 regressor or n x k matrix of regressors
    %   confidenceLevel - (Optional) Confidence level (default: 0.95 for 95% CI)
    %   numLags - (Optional) Number of lags for Newey-West
    %                        Default: 4 for standard IRF
    %                        Use -1 for automatic selection
    %
    % Outputs:
    %   lowerBound - Lower confidence bound(s)
    %   upperBound - Upper confidence bound(s)
    %
    % Example:
    %   [lower, upper] = compute_confidence_intervals(beta, residuals, vMPS);
    %   [lower, upper] = compute_confidence_intervals(beta, res, X, 0.95, 12);
    %
    % Note: Uses backslash operator instead of inv() for numerical stability
    
    % Set defaults
    if nargin < 4 || isempty(confidenceLevel)
        confidenceLevel = 0.95;
    end
    
    if nargin < 5 || isempty(numLags)
        numLags = 4;  % Default for impulse response functions
    end
    
    % Get critical value for confidence interval
    alpha = 1 - confidenceLevel;
    zCritical = norminv(1 - alpha/2);  % Two-tailed
    
    % Compute Newey-West HAC covariance matrix
    covMatrix = NeweyWest(residuals, regressor, numLags, 0);
    
    % Compute asymptotic variance: (X'X)^(-1) * V * (X'X)^(-1)
    % Using backslash for stability
    XtX = regressor' * regressor;
    
    if isscalar(XtX)
        % Scalar case (single regressor)
        asymptoticVar = (1/XtX) * covMatrix * (1/XtX);
    else
        % Matrix case (multiple regressors)
        XtX_inv = inv(XtX);  % For symmetric matrix inversion
        asymptoticVar = XtX_inv * covMatrix * XtX_inv;
    end
    
    % Extract standard error(s)
    if isscalar(asymptoticVar)
        standardError = sqrt(asymptoticVar);
    else
        % For matrix case, take diagonal elements
        standardError = sqrt(diag(asymptoticVar));
    end
    
    % Compute confidence bounds
    lowerBound = beta - zCritical * standardError;
    upperBound = beta + zCritical * standardError;
end
