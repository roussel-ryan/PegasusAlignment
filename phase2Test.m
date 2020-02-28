%{ 
script to test plane intersection between Q1 off and Q1 on in the
horizontal plane only!

This script does the following:
    Phase 1
    - does a 2D scan of the t1 trim horizontal kick strength and the t2
    trim horizontal kick strength
    - during the scan it collects the setpoints/readbacks of the trim
    magnets while measuring the beam centroid on the screen

    Phase 2
    - measures points directly on intersection line
    - turns off quad and re-measures points to verify it works 
    
Start the script with the trims off and the quad degaussed. Use earlier
trims to center the beam on the diagnostic screen.

Before running come up with some decent limits for t1,t2 values where the
beam stays on the screen. Eventually I can write something that does this
automatically
%}
%%
%Repeat phase 1 measurement

%set limits limits = [t1_x_min t1_x_max t2_x_min t2_x_max]
limits = [-1.35 -1.2 -0.1 -0.3];
axis = 'x';                     % change trims in the horizontal direction and fit horizontal centroid
npts = 5;                       % number of points along t1,t2 axis, total points = npts^2
quad_strength = 0.2;            % quad strength when the quad will be in the "on" state 

%run scan for Q1 off
data_off = scan_trims(limits,'2d',npts,axis);

%fit data
fit_off = fit_plane_to_data(data_off,axis);

%turn on quadrupole
set_quads(quad_strength,0)

%repeat scan and fit
data_on = scan_trims(limits,'2d',5,axis);

fit_on = fit_plane_to_data(data_on,axis);

%%
%scan t_2 while constraining t_1(t_2) using the plane intersections
A = fit_on(1) - fit_off(1);
B = fit_on(2) - fit_off(2);
C = fit_on(3) - fit_off(3);

intersect_fit = [-A/B -C/B];

% scan t_2 with the constraint that t_1 = t_1(t_2) with the intersection fit
% the centroid <x>(t_1(t_2),t_2) should be the same with the quad on and off
verification_data_on = scan_trims(limits(3:4), '1d_const', npts, axis, intersect_fit);

set_quads(0,0)

verification_data_off = scan_trims(limits(3:4), '1d_const', npts, axis, intersect_fit);

%if the intersection is correct the centroid difference should not change as a
%function of t_2


