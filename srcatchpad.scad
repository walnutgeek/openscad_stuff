use <poly.scad>

//profile= [[0, 13], [11, 13], [11, 12], [4, 5], [4, 0], [14, 0]];
//ease=[[0,-8],[5,undef]];

//linear_extrude(height=10) flat_hanger(2, ease, profile);

ramp = bc_poly(bezier_curve([0,-5],[0,10],[5,10]));
valley = concat(
    bc_poly(bezier_curve([0,10],[5.5,9.8],[5,9]),5), 
    bc_poly(bezier_curve([5,9],[5,7.7],[4,8]),3),
    bc_poly(bezier_curve([4,8],[3.3,7],[3,4]),5), 
    bc_poly(bezier_curve([3,4],[3,0],[7,0]),5)
); 

linear_extrude(height=7) flat_hanger(6, ramp, valley);

