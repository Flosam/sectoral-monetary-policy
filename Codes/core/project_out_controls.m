function [projectedData, projectionMatrix] = project_out_controls(data, controls)
    % PROJECT_OUT_CONTROLS - Project out control variables using Frisch-Waugh theorem
    %
    % Implements the Frisch-Waugh-Lovell theorem to partial out the effect of
    % control variables from the data. This is equivalent to regressing data on
    % controls and taking the residuals.
    %
    % The projection matrix is: M_X = I - X(X'X)^(-1)X'
    % where X includes a constant term and all control variables.
    %
    % Inputs:
    %   data - n x 1 vector or n x k matrix to be projected
    %   controls - n x p matrix of control variables (constant is added automatically)
    %
    % Outputs:
    %   projectedData - n x 1 or n x k matrix with controls projected out
    %   projectionMatrix - n x n projection matrix (optional)
    %
    % Example:
    %   projectedPCE = project_out_controls(vPCE, [vPCElag vMPSlag]);
    %   [projectedPCE, M] = project_out_controls(vPCE, mControls);
    %
    % Note: Uses backslash operator instead of inv() for numerical stability
    
    % Get dimensions
    numObservations = size(data, 1);
    
    % Validate inputs
    if size(controls, 1) ~= numObservations
        error('project_out_controls:DimensionMismatch', ...
            'Data has %d rows but controls has %d rows', ...
            numObservations, size(controls, 1));
    end
    
    % Add constant term to controls
    controlsWithConstant = [ones(numObservations, 1), controls];
    
    % Compute projection matrix M_X = I - X(X'X)^(-1)X'
    % Using backslash for numerical stability: (X'X)^(-1)X' = X \ I
    % So: X(X'X)^(-1)X' = X * (X'X \ X')
    % More efficient: X * ((X'X) \ X') = controlsWithConstant * ((controlsWithConstant' * controlsWithConstant) \ controlsWithConstant')
    
    % Even more numerically stable formulation:
    % M_X * y = y - X * (X \ y)
    projectedData = data - controlsWithConstant * (controlsWithConstant \ data);
    
    % If projection matrix is requested, compute it explicitly
    if nargout > 1
        % M = I - X * (X'X)^(-1) * X'
        % Using backslash: M = I - X * ((X'X) \ X')
        XtX_inv_Xt = (controlsWithConstant' * controlsWithConstant) \ controlsWithConstant';
        projectionMatrix = eye(numObservations) - controlsWithConstant * XtX_inv_Xt;
    end
end
