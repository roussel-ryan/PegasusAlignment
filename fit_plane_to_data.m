function [fit,MSE] = fit_plane_to_data(collected_data,axis)
%FIT_PLANE_TO_DATA Get plane parameters that fit to the data collected 
%   collected_data in the form of [t1_x t1_y t2_x t2_y centroid_x centroid_y]
%   parameters are fit to the equation z = fit[1] + fit[2]*t1_axis +
%   fit[3]*t2_axis
    if strcmp(axis,'x')
        add_axis = 0;
    elseif strcmp(axis,'y')
        add_axis = 1;
    else
        error('axis argument not recognized!')
    end
     
    %collect data
    t1 = collected_data(:,1 + add_axis);
    t2 = collected_data(:,3 + add_axis);
    cen = collected_data(:,5 + add_axis);
    
    %remove points where the centroid is not found cen = Nan
    is_nan = isnan(cen);
    t1 = t1(~is_nan);
    t2 = t2(~is_nan);
    cen = cen(~is_nan);
    
    %create an array with the same shape as t1
    ones_like = t1*0 + 1;
    
    %calculate fit using Normal Equation (least square fitting)
    %"design matrix"
    phi = [ones_like t1 t2];
    
    %least squares fit
    fit = inv(phi.' * phi) * phi.' * cen;
    
    %calculate MSE (mean squared error)
    MSE = (1 / length(cen)) * (cen - phi * fit).' * (cen - phi * fit);
    

end

