function validate_inputs(varargin)
    % VALIDATE_INPUTS - Validate input dimensions, types, and values
    %
    % Syntax:
    %   validate_inputs('ParamName', value, 'validator1', arg1, 'validator2', arg2, ...)
    %
    % Validators:
    %   'size', [rows, cols] - Check matrix dimensions
    %   'length', n - Check vector length
    %   'type', classname - Check data type
    %   'nonnan' - Check for NaN values
    %   'nonempty' - Check not empty
    %   'positive' - Check all values > 0
    %   'nonnegative' - Check all values >= 0
    %
    % Example:
    %   validate_inputs('price', p, 'type', 'timetable', 'nonempty');
    %   validate_inputs('horizon', iH, 'type', 'double', 'positive');
    
    if mod(length(varargin), 2) ~= 0
        error('validate_inputs:InvalidUsage', ...
            'Arguments must come in pairs: ''name'', value, ''validator'', arg, ...');
    end
    
    i = 1;
    while i <= length(varargin)
        paramName = varargin{i};
        paramValue = varargin{i+1};
        
        % Process validators until we hit next parameter name
        i = i + 2;
        while i <= length(varargin) && ~ischar(varargin{i})
            error('validate_inputs:InvalidFormat', ...
                'Expected validator name (string) at position %d', i);
        end
        
        % Apply validators
        j = i;
        while j <= length(varargin)
            validator = varargin{j};
            
            % Check if this is a new parameter (would be followed by a value)
            if j+1 <= length(varargin) && ...
               j+2 <= length(varargin) && ...
               ischar(varargin{j+2})
                % Likely start of new parameter pair
                break;
            end
            
            switch validator
                case 'nonempty'
                    if isempty(paramValue)
                        error('validate_inputs:EmptyInput', ...
                            'Parameter ''%s'' cannot be empty', paramName);
                    end
                    j = j + 1;
                    
                case 'nonnan'
                    if any(isnan(paramValue(:)))
                        error('validate_inputs:NaNDetected', ...
                            'Parameter ''%s'' contains NaN values', paramName);
                    end
                    j = j + 1;
                    
                case 'type'
                    expectedType = varargin{j+1};
                    if ~isa(paramValue, expectedType)
                        error('validate_inputs:TypeMismatch', ...
                            'Parameter ''%s'' must be of type ''%s'', got ''%s''', ...
                            paramName, expectedType, class(paramValue));
                    end
                    j = j + 2;
                    
                case 'size'
                    expectedSize = varargin{j+1};
                    actualSize = size(paramValue);
                    if ~isequal(actualSize, expectedSize)
                        error('validate_inputs:SizeMismatch', ...
                            'Parameter ''%s'' must have size [%s], got [%s]', ...
                            paramName, num2str(expectedSize), num2str(actualSize));
                    end
                    j = j + 2;
                    
                case 'length'
                    expectedLength = varargin{j+1};
                    actualLength = length(paramValue);
                    if actualLength ~= expectedLength
                        error('validate_inputs:LengthMismatch', ...
                            'Parameter ''%s'' must have length %d, got %d', ...
                            paramName, expectedLength, actualLength);
                    end
                    j = j + 2;
                    
                case 'positive'
                    if any(paramValue(:) <= 0)
                        error('validate_inputs:NotPositive', ...
                            'Parameter ''%s'' must contain only positive values', ...
                            paramName);
                    end
                    j = j + 1;
                    
                case 'nonnegative'
                    if any(paramValue(:) < 0)
                        error('validate_inputs:Negative', ...
                            'Parameter ''%s'' must contain only non-negative values', ...
                            paramName);
                    end
                    j = j + 1;
                    
                otherwise
                    % Not a validator we recognize, might be next parameter
                    break;
            end
        end
        
        i = j;
    end
end
