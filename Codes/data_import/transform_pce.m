function [pce_price_log, pce_quant_log, pce_price_gr, pce_quant_gr] = transform_pce(pce_price_all, pce_quant_all)
    % TRANSFORM_PCE - Transform PCE data into log levels and growth rates
    %
    % Computes log levels (scaled by 100) and year-over-year growth rates
    % for PCE price and quantity indices.
    %
    % Inputs:
    %   pce_price_all - Timetable of raw price index data
    %   pce_quant_all - Timetable of raw quantity index data
    %
    % Outputs:
    %   pce_price_log - Timetable of log price levels (x100)
    %   pce_quant_log - Timetable of log quantity levels (x100)
    %   pce_price_gr - Timetable of year-over-year price growth rates (%)
    %   pce_quant_gr - Timetable of year-over-year quantity growth rates (%)
    %
    % Example:
    %   [p_log, q_log, p_gr, q_gr] = transform_pce(price_raw, quant_raw);
    
    fprintf('Transforming PCE data...\n');
    
    % Compute log levels (scaled by 100)
    pce_price_log = log(pce_price_all) .* 100;
    pce_quant_log = log(pce_quant_all) .* 100;
    
    % Compute year-over-year growth rates
    % Growth rate = (log(x_t) - log(x_{t-12})) * 100
    % Note: log levels are already × 100, so difference gives growth rate in %
    pce_price_gr = pce_price_log;
    pce_quant_gr = pce_quant_log;
    
    pce_price_gr.Variables = pce_price_log.Variables - ...
        lagmatrix(pce_price_log.Variables, 12);
    pce_quant_gr.Variables = pce_quant_log.Variables - ...
        lagmatrix(pce_quant_log.Variables, 12);
    
    fprintf('Computed log transformations and growth rates\n');
end
