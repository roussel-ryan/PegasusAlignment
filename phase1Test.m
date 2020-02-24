%{ 
script to test plane intersection between Q1 off and Q1 on in the
horizontal plane only!

This script does the following:
    - does a 2D scan of the t1 trim horizontal kick strength and the t2
    trim horizontal kick strength
    - during the scan it collects the setpoints/readbacks of the trim
    magnets while measuring the beam centroid on the screen
    
Start the script with the trims off and the quad degaussed. Use earlier
trims to center the beam on the diagnostic screen.

Before running come up with some decent limits for t1,t2 values where the
beam stays on the screen. Eventually I can write something that does this
automatically
%}

%set limits limits = [t1_x_min t1_x_max t2_x_min t2_x_max]
limits = [-0.1 0.1 -0.1 0.1];
axis = 'x';                     % change trims in the horizontal direction and fit horizontal centroid
npts = 5;                       % number of points along t1,t2 axis, total points = npts^2
quad_strength = 0.1;            % quad strength when the quad will be in the "on" state 

%run scan for Q1 off
data_off = scan_trims(limits,'2d',npts,axis);

%fit data
fit_off = fit_plane_to_data(data_off,axis);

%turn on quadrupole
set_quads(quad_strength,0)

%repeat scan and fit
data_on = scan_trims(limits,'2d',5,axis);
fit_on = fit_plane_to_data(data_on,axis);







