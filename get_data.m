function [data] = get_data()
%GET_DATA Collect readback values/setpoints of magnets and beam statistics
%   data should be in the form [t1_x t1_y t2_x t2_y centroid_x centroid_y]
%   if the beam is no longer on the screen return Nan for
%   centroid_x,centroid_y
    conn=database('pegasus','pegasus','3l3ctr0ns'); 
    tableStr = ' pimax ';
    tableStr2 = ' pegmagnets_new ';
    datacc = cell2mat(fetch(conn,strcat('SELECT rudyshot,xc,yc FROM ',tableStr, ' ORDER BY rudyshot DESC LIMIT 1;')));
    sqlquery = strcat('SELECT steering_h2,steering_v2,steering_h3, steering_v3 ',...
                      ' FROM pegmagnets_new WHERE rudyshot = ',num2str(datacc(1)), ';'); 
    results = fetch(conn,sqlquery);
    datamag = cell2mat(results);
    data = [datamag datacc(2) datacc(3)]
    close(conn)
end

