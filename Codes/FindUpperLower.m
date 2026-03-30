function bounds = FindUpperLower(testResults, parameterGrid)
    % FINDUPPERLOWER - Find confidence set bounds from AR test results
    %
    % Finds the upper and lower bounds of the Anderson-Rubin confidence set
    % by identifying the boundary points where the null hypothesis is not rejected.
    %
    % Inputs:
    %   testResults - n x 1 binary vector (1 = not rejected, 0 = rejected)
    %   parameterGrid - n x 1 vector of parameter values tested
    %
    % Outputs:
    %   bounds - [lowerBound, upperBound] 2-element vector
    %
    % Example:
    %   [lower, upper] = FindUpperLower(mTest(:,h), betaGrid);
    %
    % Note: Returns the smallest and largest parameter values where the
    %       null is not rejected, defining the confidence interval.
    
    bounds = zeros(1, 2);
    
    % Find lower bound (search from bottom up)
    for k = 1:length(parameterGrid)-1
        if testResults(k) ~= 0
            bounds(1) = parameterGrid(k);
            break;
        end
        
        if testResults(k) ~= 0 && testResults(k+1) == 0
            bounds(1) = parameterGrid(k+1);
            break;
        end
    end
    
    % Find upper bound (search from top down)
    for k = length(parameterGrid):-1:2
        if testResults(k) ~= 0
            bounds(2) = parameterGrid(k);
            break;
        end
        
        if testResults(k) ~= 0 && testResults(k-1) == 0
            bounds(2) = parameterGrid(k-1);
            break;
        end
    end
end
