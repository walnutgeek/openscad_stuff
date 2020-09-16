use <2d.scad>

ramp = bc_poly(bezier_curve([0,-5],[0,10],[5,10]));
valley = concat(
    bc_poly(bezier_curve([0,10],[5.3,10],[4.9,9])), 
    bc_poly(bezier_curve([4.9,9],[5,7.7],[4,7.8])),
    bc_poly(bezier_curve([4,7.8],[3.3,7],[3,4])), 
    bc_poly(bezier_curve([3,4],[3,0],[7,0]))
); 

linear_extrude(height=8) flat_hanger(6, ramp, valley);
