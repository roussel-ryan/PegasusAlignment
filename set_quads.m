function [outputArg1,outputArg2] = set_quads(quad_1,quad_2)
%SET_MAGNETS Set magnet strengths
%   Open database connection and writes to ML_control the quad values
%   External control of the magnets must be enable on Pegasus Control VI
    conn=database('pegasus','pegasus','3l3ctr0ns'); 
    tablename = 'ml_control';
    colnames={'q4','q6'};
    data = {quad_1, quad_2};
    whereclause = '';
    update(conn,tablename,colnames,data,whereclause);
    sqlquery = 'SELECT q4,q6 FROM ml_control';
    results = fetch(conn,sqlquery);
    output = cell2mat(results);
    close(conn)
    outputArg1 = output(1);
    outputArg2 = output(2);
end

