%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GET_PM - Estimate Phillips Multiplier using Local Projections
%
% Calculates the Phillips Multiplier (the ratio of price to quantity responses
% to monetary policy shocks) using instrumental variables and weak-instrument
% robust inference methods.
%
% Created by: Florent Samson
% Last modified: 2025/02/20
% 
% Reference:
%   Methodology from Geert Mesters
%   https://www.geertmesters.com/publications 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function results = get_pm(p, q, mps, startDate, endDate)
    % GET_PM - Main function to estimate Phillips Multiplier
    %
    % Inputs:
    %   p - Timetable of price index (log differences)
    %   q - Timetable of quantity index (log differences)
    %   mps - Timetable of monetary policy shocks
    %   startDate - Start date for analysis (string or datetime)
    %   endDate - End date for analysis (string or datetime)
    %
    % Outputs:
    %   results - Structure with PM estimates, confidence bounds, and IRFs
    
    % Input validation
    if ~istimetable(p)
        error('get_pm:InvalidInput', 'Price data (p) must be a timetable');
    end
    if ~istimetable(q)
        error('get_pm:InvalidInput', 'Quantity data (q) must be a timetable');
    end
    if ~istimetable(mps)
        error('get_pm:InvalidInput', 'MPS data must be a timetable');
    end
    if isempty(p) || isempty(q) || isempty(mps)
        error('get_pm:EmptyInput', 'Input data cannot be empty');
    end
    
    % Convert dates to datetime
    try
        startDate = datetime(startDate);
        endDate = datetime(endDate);
    catch ME
        error('get_pm:InvalidDate', 'Invalid date format: %s', ME.message);
    end
    
    % Validate date range
    if startDate >= endDate
        error('get_pm:InvalidDateRange', 'Start date must be before end date');
    end
    
    % Synchronize data and filter by date range
    mObs = synchronize(p, q, mps);
    mObs = mObs(mObs.Time >= startDate & mObs.Time <= endDate, :);
    
    % Check if date range contains data
    if isempty(mObs)
        error('get_pm:NoData', ...
            'No data available in date range %s to %s', ...
            datestr(startDate), datestr(endDate));
    end
    
    % Remove missing observations and report statistics
    mObs_before = mObs;
    mObs = rmmissing(mObs);
    report_missing(mObs_before, mObs, 'Phillips Multiplier Data');
    
    % Verify sufficient observations remain
    if height(mObs) < 50
        warning('get_pm:FewObservations', ...
            'Only %d observations after removing missing data. Results may be unreliable.', ...
            height(mObs));
    end
    
    % Calculate Phillips Multiplier
    results = calc_pm(mObs{:,3}, mObs{:,1}, mObs{:,2});
end


function results = calc_pm(mMPS, vP, vQ)
    % CALC_PM - Calculate Phillips Multiplier for all horizons
    %
    % Estimates PM using 2SLS with weak-instrument robust AR bounds
    
    % Load configuration
    config = ProjectConfig.get();
    iH = config.HORIZON;
    numLags = config.NUM_LAGS;
    
    % Create control variables (lags of price and quantity)
    mControls = [lagmatrix(vP, 1:numLags), lagmatrix(vQ, 1:numLags)];
    
    % Get AR testing grid
    betaGrid = config.getARGrid();
    numBetas = length(betaGrid);
    
    % Initialize results structure
    results = struct;
    results.vBeta = zeros(iH, 1);          % 2SLS Phillips Multiplier
    results.vBetauc = zeros(iH, 1);        % OLS unconditional multiplier
    results.vBetaP = zeros(iH, 1);         % Price IRF
    results.vBetaQ = zeros(iH, 1);         % Quantity IRF
    results.vLowerAR = zeros(iH, 1);       % AR lower bound
    results.vUpperAR = zeros(iH, 1);       % AR upper bound
    results.vLowerAR2s = zeros(iH, 1);     % 2SLS lower bound
    results.vUpperAR2s = zeros(iH, 1);     % 2SLS upper bound
    results.vLowerARuc = zeros(iH, 1);     % Unconditional lower bound
    results.vUpperARuc = zeros(iH, 1);     % Unconditional upper bound
    results.vLowerP = zeros(iH, 1);        % Price IRF lower bound
    results.vUpperP = zeros(iH, 1);        % Price IRF upper bound
    results.vLowerQ = zeros(iH, 1);        % Quantity IRF lower bound
    results.vUpperQ = zeros(iH, 1);        % Quantity IRF upper bound
    results.vFstat = zeros(iH, 1);         % Effective F-statistics
    results.vParB = betaGrid;              % Grid of beta parameters
    results.mWald = zeros(numBetas, iH);   % Wald statistics
    results.mTest = zeros(numBetas, iH);   % AR test results
    results.iH = iH;                       % Horizon
    
    % Compute multiplier for each horizon h = 0, 1, 2, ...
    for h = 1:iH
        % Construct cumulative price and quantity
        vPc = vP;
        vQc = vQ;
        if h > 1
            for j = 2:h
                vPc = vPc + lagmatrix(vP, -(j-1));
                vQc = vQc + lagmatrix(vQ, -(j-1));
            end
        end
        
        % Combine data and remove missing observations
        mObs = [vPc, vQc, mMPS, mControls];
        mObs = rmmissing(mObs);
        numObs = size(mObs, 1);
        
        % Extract variables
        vPc_clean = mObs(:, 1);
        vQc_clean = mObs(:, 2);
        mMPS_clean = mObs(:, 3);
        mControls_clean = mObs(:, 4:end);
        
        % Project out constant and control variables
        vPc_proj = project_out_controls(vPc_clean, mControls_clean);
        vQc_proj = project_out_controls(vQc_clean, mControls_clean);
        % Note: MPS is not projected out (it's the instrument)
        
        % ===== 2SLS Estimation =====
        % First stage: Q ~ MPS (already projected)
        % Second stage: P ~ Q_hat using MPS as instrument
        % Combined formula: β = (Q'P_MPS Q)^(-1) Q'P_MPS P
        % where P_MPS = MPS(MPS'MPS)^(-1)MPS' is the projection matrix
        
        mProjectionMPS = mMPS_clean * ((mMPS_clean' * mMPS_clean) \ mMPS_clean');
        results.vBeta(h) = (vQc_proj' * mProjectionMPS * vQc_proj) \ ...
                          (vQc_proj' * mProjectionMPS * vPc_proj);
        
        % 2SLS standard errors
        vResiduals2SLS = vPc_proj - results.vBeta(h) * vQc_proj;
        mCov2SLS = NeweyWest(vResiduals2SLS, mMPS_clean, -1, 0);
        mAvar2SLS = (vQc_proj' * mProjectionMPS * vQc_proj) \ ...
                   (vQc_proj' * mMPS_clean * ((mMPS_clean' * mMPS_clean) \ mCov2SLS) * ...
                   ((mMPS_clean' * mMPS_clean) \ mMPS_clean') * vQc_proj) / ...
                   (vQc_proj' * mProjectionMPS * vQc_proj);
        results.vLowerAR2s(h) = results.vBeta(h) - config.Z_CRITICAL * sqrt(mAvar2SLS);
        results.vUpperAR2s(h) = results.vBeta(h) + config.Z_CRITICAL * sqrt(mAvar2SLS);
        
        % ===== AR Confidence Bounds =====
        [results.vLowerAR(h), results.vUpperAR(h), ...
         results.mWald(:,h), results.mTest(:,h)] = ...
            compute_ar_bounds(vPc_proj, vQc_proj, mMPS_clean, betaGrid);
        
        % ===== Effective F-statistic =====
        results.vFstat(h) = EffectiveFstat(vQc_proj, mMPS_clean);
        
        % ===== Price IRF =====
        results.vBetaP(h) = (mMPS_clean' * mMPS_clean) \ (mMPS_clean' * vPc_proj);
        vResidualsP = vPc_proj - mMPS_clean * results.vBetaP(h);
        [results.vLowerP(h), results.vUpperP(h)] = compute_confidence_intervals(...
            results.vBetaP(h), vResidualsP, mMPS_clean, 1 - config.ALPHA, numLags);
        
        % ===== Quantity IRF =====
        results.vBetaQ(h) = (mMPS_clean' * mMPS_clean) \ (mMPS_clean' * vQc_proj);
        vResidualsQ = vQc_proj - mMPS_clean * results.vBetaQ(h);
        [results.vLowerQ(h), results.vUpperQ(h)] = compute_confidence_intervals(...
            results.vBetaQ(h), vResidualsQ, mMPS_clean, 1 - config.ALPHA, numLags);
        
        % ===== Unconditional (OLS) Phillips Multiplier =====
        results.vBetauc(h) = (vQc_proj' * vQc_proj) \ (vQc_proj' * vPc_proj);
        vResidualsUC = vPc_proj - results.vBetauc(h) * vQc_proj;
        mCovUC = NeweyWest(vResidualsUC, vQc_proj, -1, 0);
        mAvarUC = (vQc_proj' * vQc_proj) \ mCovUC / (vQc_proj' * vQc_proj);
        results.vLowerARuc(h) = results.vBetauc(h) - config.Z_CRITICAL * sqrt(mAvarUC);
        results.vUpperARuc(h) = results.vBetauc(h) + config.Z_CRITICAL * sqrt(mAvarUC);
    end
end