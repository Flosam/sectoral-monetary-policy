function effectiveFstat = EffectiveFstat(vX, mZ)
    % EFFECTIVEFSTAT - Compute effective F-statistic for weak instrument testing
    %
    % Calculates the Montiel Olea-Pflueger effective F-statistic, which is
    % robust to heteroskedasticity and autocorrelation. Used to assess
    % instrument strength in IV regression.
    %
    % Inputs:
    %   vX - n x 1 endogenous variable (e.g., quantity)
    %   mZ - n x L matrix of instruments (e.g., monetary policy shocks)
    %
    % Outputs:
    %   effectiveFstat - Effective F-statistic
    %
    % Example:
    %   fstat = EffectiveFstat(quantity, mps);
    %
    % Reference:
    %   Montiel Olea, J. L., & Pflueger, C. (2013). "A robust test for weak 
    %   instruments." Journal of Business & Economic Statistics, 31(3), 358-369.
    
    % Demean instruments
    mZnorm = mZ - mean(mZ, 1);
    
    % Compute Z'Z
    mZZ = mZnorm' * mZnorm;
    
    % Orthogonalize instruments using Cholesky decomposition
    mZnorm = mZnorm * chol(inv(mZZ), 'lower');
    
    % OLS reduced form regression: X = Z*β + ε
    vCoefs = (mZnorm' * mZnorm) \ (mZnorm' * vX);
    vResiduals = vX - mZnorm * vCoefs;
    
    % HAC variance-covariance matrix using Newey-West
    mCovMatrix = NeweyWest(vResiduals, mZnorm, 4, 0);
    
    % Compute effective F-statistic
    effectiveFstat = (vX' * mZnorm * mZnorm' * vX) / trace(mCovMatrix);
end
