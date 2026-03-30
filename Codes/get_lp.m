function results = get_lp(p, q, mps, startDate, endDate)
    % GET_LP - Estimate local projection impulse responses for price and quantity
    %
    % Estimates the impulse response of PCE price and quantity indices to
    % monetary policy shocks using the local projection method of Jordà (2005).
    %
    % Inputs:
    %   p - Timetable of price index (log differences)
    %   q - Timetable of quantity index (log differences)
    %   mps - Timetable of monetary policy shocks
    %   startDate - Start date for analysis (string or datetime)
    %   endDate - End date for analysis (string or datetime)
    %
    % Outputs:
    %   results - Structure with fields:
    %       .price - Local projection results for price (vBeta, vLower, vUpper)
    %       .quant - Local projection results for quantity (vBeta, vLower, vUpper)
    %
    % Example:
    %   results = get_lp(price_log_lvl{1}, quant_log_lvl{1}, mps_ad, ...
    %                    '1982-01-01', '2008-01-01');
    %
    % Reference:
    %   Jordà, Ò. (2005). "Estimation and Inference of Impulse Responses 
    %   by Local Projections". American Economic Review, 95(1), 161-182.
    
    % Input validation
    if ~istimetable(p)
        error('get_lp:InvalidInput', 'Price data (p) must be a timetable');
    end
    if ~istimetable(q)
        error('get_lp:InvalidInput', 'Quantity data (q) must be a timetable');
    end
    if ~istimetable(mps)
        error('get_lp:InvalidInput', 'MPS data must be a timetable');
    end
    if isempty(p) || isempty(q) || isempty(mps)
        error('get_lp:EmptyInput', 'Input data cannot be empty');
    end
    
    % Convert dates to datetime
    try
        startDate = datetime(startDate);
        endDate = datetime(endDate);
    catch ME
        error('get_lp:InvalidDate', 'Invalid date format: %s', ME.message);
    end
    
    % Validate date range
    if startDate >= endDate
        error('get_lp:InvalidDateRange', 'Start date must be before end date');
    end
    
    % Import control variables
    macroCtrl = import_controls();
    
    % Synchronize data and filter by date range
    mObs = synchronize(p, q, mps, macroCtrl);
    mObs = mObs(mObs.Time >= startDate & mObs.Time <= endDate, :);
    
    % Check if date range contains data
    if isempty(mObs)
        error('get_lp:NoData', ...
            'No data available in date range %s to %s', ...
            datestr(startDate), datestr(endDate));
    end
    
    % Remove missing observations and report statistics
    mObs_before = mObs;
    mObs = rmmissing(mObs);
    report_missing(mObs_before, mObs, 'Local Projection Data');
    
    % Verify sufficient observations remain
    if height(mObs) < 50
        warning('get_lp:FewObservations', ...
            'Only %d observations after removing missing data. Results may be unreliable.', ...
            height(mObs));
    end
    
    % Run local projection for price and quantity
    results.price = calc_lp(mObs{:,1}, mObs{:,3}, mObs{:,4:end});
    results.quant = calc_lp(mObs{:,2}, mObs{:,3}, mObs{:,4:end});
end

function results = calc_lp(vPCE, vMPS, mMacroCtrl)
    % CALC_LP - Calculate local projection impulse response function
    %
    % For each horizon h, regresses y_{t+h} on shock_t and controls:
    % y_{t+h} = β_h * shock_t + γ' * controls_t + ε_t
    % Controls are projected out using Frisch-Waugh theorem.
    
    % Load configuration
    config = ProjectConfig.get();
    iH = config.HORIZON;
    
    % Compute controls from input data
    mMPSLags = lagmatrix(vMPS, 1:config.MPS_LAGS);
    vPCELag = lagmatrix(vPCE, 1:config.PCE_LAGS);
    
    % Combine controls (PCE lag + MPS lags)
    % Note: macro controls currently not used per original code
    mControls = [vPCELag, mMPSLags];
    
    % Initialize results structure
    results = struct;
    results.vBeta = zeros(iH, 1);
    results.vLower = zeros(iH, 1);
    results.vUpper = zeros(iH, 1);
    
    % Compute regression for every horizon
    for h = 1:iH
        % Get dependent variable at time t+h
        vPCEh = lagmatrix(vPCE, -(h-1));
        
        % Combine data and remove missing observations
        mObs = [vPCEh, vMPS, mControls];
        mObs = rmmissing(mObs);
        
        % Extract variables after removing missing data
        vPCEh_clean = mObs(:, 1);
        vMPS_clean = mObs(:, 2);
        mControls_clean = mObs(:, 3:end);
        
        % Project out constant and control variables from dependent variable
        vPCEh_proj = project_out_controls(vPCEh_clean, mControls_clean);
        
        % Compute IRF coefficient: β = (X'X)^(-1) X'y
        results.vBeta(h) = (vMPS_clean' * vMPS_clean) \ (vMPS_clean' * vPCEh_proj);
        
        % Compute residuals
        vResiduals = vPCEh_proj - vMPS_clean * results.vBeta(h);
        
        % Compute confidence intervals using Newey-West HAC
        [results.vLower(h), results.vUpper(h)] = compute_confidence_intervals(...
            results.vBeta(h), vResiduals, vMPS_clean, 1 - config.ALPHA, 4);
    end
end
