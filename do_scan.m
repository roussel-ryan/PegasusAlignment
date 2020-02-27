function [centroid_data] = do_scan(pts)
%DO_SCAN Summary of this function goes here
%   Detailed explanation goes here
    %take multiple samples at a given point to measure noise
    n_repeats = 1;
    pause_time_seconds = 1.0;
   
    centroid_data = zeros(length(pts)*n_repeats,6);
    k = 1;
    for i = 1:length(pts)*n_repeats
        set_trims(pts(:,i));
        pause(pause_time_seconds)
        for j = 1:n_repeats
            centroid_data(k,:) = get_data();
            k = k + 1;
            pause(pause_time_seconds)
        end
    end
end

