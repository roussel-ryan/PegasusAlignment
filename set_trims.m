function [] = set_trims(trim_values)
%DO_SCAN Set trim values
%  trim_values has the form [t1_x t1_y t2_x t2_y]v
%   Open database connection and writes to ML_control the steering magnet values
%   External control of the steering magnets must be enable on Pegasus Control VI
   
    conn=database('pegasus','pegasus','3l3ctr0ns'); 
    tablename = 'ml_control';
    colnames={'h2','v2','h3','v3'};
    data = {trim_values(1), trim_values(2), trim_values(3), trim_values(4)};
    whereclause = '';
    update(conn,tablename,colnames,data,whereclause)

    sqlquery = 'SELECT h2,v2,h3,v3 FROM ml_control';
    results = fetch(conn,sqlquery);
    cell2mat(results)
    close(conn)
end
