function stats = report_missing(dataBefore, dataAfter, dataName)
    % REPORT_MISSING - Report statistics on missing data removal
    %
    % Inputs:
    %   dataBefore - Data matrix or table before removing missing values
    %   dataAfter - Data matrix or table after removing missing values
    %   dataName - (Optional) Name of dataset for display
    %
    % Outputs:
    %   stats - Structure with fields:
    %       .rowsBefore - Number of rows before cleaning
    %       .rowsAfter - Number of rows after cleaning
    %       .rowsRemoved - Number of rows removed
    %       .percentRemoved - Percentage of rows removed
    %
    % Example:
    %   stats = report_missing(mObs_raw, mObs_clean, 'PCE Data');
    
    if nargin < 3
        dataName = 'Data';
    end
    
    % Get row counts
    if istable(dataBefore) || istimetable(dataBefore)
        rowsBefore = height(dataBefore);
        rowsAfter = height(dataAfter);
    else
        rowsBefore = size(dataBefore, 1);
        rowsAfter = size(dataAfter, 1);
    end
    
    % Calculate statistics
    stats.rowsBefore = rowsBefore;
    stats.rowsAfter = rowsAfter;
    stats.rowsRemoved = rowsBefore - rowsAfter;
    stats.percentRemoved = 100 * stats.rowsRemoved / rowsBefore;
    
    % Display report
    if stats.rowsRemoved > 0
        fprintf('[%s] Removed %d/%d rows (%.1f%%) due to missing values\n', ...
            dataName, stats.rowsRemoved, rowsBefore, stats.percentRemoved);
    else
        fprintf('[%s] No missing values detected (%d rows)\n', ...
            dataName, rowsBefore);
    end
end
