function [data] = get_data()
%GET_DATA Collect readback values/setpoints of magnets and beam statistics
%   data should be in the form [t1_x t1_y t2_x t2_y centroid_x centroid_y]
%   if the beam is no longer on the screen return Nan for
%   centroid_x,centroid_y
    data = [1 1 1 1 1 1];
end

