function [price_lvl_data, quant_lvl_data] = split_by_level(price, quant)
    % SPLIT_BY_LEVEL - Divide PCE data by hierarchical disaggregation level
    %
    % Separates PCE data into 7 levels (0-6) of hierarchical disaggregation
    % based on the classification from Aruoba & Drechsel (2023).
    %
    % Inputs:
    %   price - Timetable of price data (all categories)
    %   quant - Timetable of quantity data (all categories)
    %
    % Outputs:
    %   price_lvl_data - 7x1 cell array, each cell contains timetable for that level
    %   quant_lvl_data - 7x1 cell array, each cell contains timetable for that level
    %
    % Example:
    %   [price_by_lvl, quant_by_lvl] = split_by_level(pce_price_log, pce_quant_log);
    %
    % Reference:
    %   Level structure from Aruoba & Drechsel (2023): "The long and variable
    %   lags of monetary policy: Evidence from disaggregated price indices"
    
    % Import level index mapping
    index_file = 'Data/Raw/Index_Level.xlsx';
    if ~exist(index_file, 'file')
        error('split_by_level:FileNotFound', ...
            'Level index file not found: %s\nPlease ensure Index_Level.xlsx exists in Data/Raw/', ...
            index_file);
    end
    
    lvl_indices = readtable(index_file);
    
    % Validate that level indices match data dimensions
    if max(lvl_indices.Level) > 6
        warning('split_by_level:UnexpectedLevel', ...
            'Found levels greater than 6 in index file');
    end
    
    % Initialize cell arrays for each level (0-6 = 7 levels)
    price_lvl_data = cell(7, 1);
    quant_lvl_data = cell(7, 1);
    
    fprintf('Splitting data by hierarchical level...\n');
    
    % Split data by level
    for i = 0:6
        ind = find(lvl_indices.Level == i);
        
        if isempty(ind)
            warning('split_by_level:EmptyLevel', 'No categories found for level %d', i);
            price_lvl_data{i+1} = [];
            quant_lvl_data{i+1} = [];
            continue;
        end
        
        % Extract data for this level
        q = quant(:, ind);
        p = price(:, ind);
        
        price_lvl_data{i+1} = p;
        quant_lvl_data{i+1} = q;
        
        fprintf('  Level %d: %d categories\n', i, length(ind));
    end
    
    fprintf('Data split complete\n');
end
