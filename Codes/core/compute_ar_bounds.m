function [lowerBound, upperBound, waldStats, testResults] = compute_ar_bounds(vPrice, vQuantity, mMPS, betaGrid)
    % COMPUTE_AR_BOUNDS - Compute Anderson-Rubin confidence bounds for Phillips Multiplier
    %
    % Implements the Anderson-Rubin (AR) weak-instrument robust inference method
    % to construct confidence intervals for the Phillips Multiplier parameter.
    %
    % Methodology:
    %   For each candidate value β in the grid:
    %   1. Construct implied residual: ε = P - β*Q
    %   2. Test if ε is orthogonal to instruments using Wald statistic
    %   3. Accept β if Wald stat < chi-squared critical value
    %   4. Confidence set = {β : not rejected}
    %
    % Inputs:
    %   vPrice - n x 1 vector of (cumulative) price changes
    %   vQuantity - n x 1 vector of (cumulative) quantity changes  
    %   mMPS - n x 1 vector of monetary policy shock (instrument)
    %   betaGrid - k x 1 vector of beta values to test
    %
    % Outputs:
    %   lowerBound - Lower bound of AR confidence set
    %   upperBound - Upper bound of AR confidence set
    %   waldStats - k x 1 vector of Wald statistics for each beta
    %   testResults - k x 1 binary vector (1 = not rejected, 0 = rejected)
    %
    % Example:
    %   config = ProjectConfig.get();
    %   betaGrid = config.getARGrid();
    %   [lower, upper] = compute_ar_bounds(vP, vQ, mMPS, betaGrid);
    
    % Get number of beta values to test
    numBetas = length(betaGrid);
    
    % Initialize storage
    waldStats = zeros(numBetas, 1);
    testResults = zeros(numBetas, 1);
    
    % Critical value for chi-squared test (95% confidence, 1 degree of freedom)
    criticalValue = chi2inv(0.95, 1);
    
    % Test each beta value
    for k = 1:numBetas
        beta = betaGrid(k);
        
        % Construct residual under null hypothesis β = beta
        vResiduals = vPrice - beta * vQuantity;
        
        % Moment condition: E[Z'ε] = 0 where Z is the instrument (MPS)
        vGamma = mMPS' * vResiduals;
        
        % Project out instruments from residuals for variance estimation
        vResiduals_proj = vResiduals - mMPS * ((mMPS' * mMPS) \ vGamma);
        
        % Compute HAC covariance matrix using Newey-West
        % Use -1 for automatic lag selection
        mCovMatrix = NeweyWest(vResiduals_proj, mMPS, -1, 0);
        
        % Compute Wald statistic: γ' * V^(-1) * γ
        waldStats(k) = vGamma' * (mCovMatrix \ vGamma);
        
        % Test if not rejected at 5% level
        if waldStats(k) < criticalValue
            testResults(k) = 1;
        end
    end
    
    % Find upper and lower confidence bounds
    bounds = FindUpperLower(testResults, betaGrid);
    lowerBound = bounds(1);
    upperBound = bounds(2);
end
