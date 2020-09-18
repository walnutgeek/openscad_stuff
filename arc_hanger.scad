use <2d.scad>


ramp = bc_poly(bezier_curve([0,-5],[0,10],[5,10]));
valley = concat(
    bc_poly(bezier_curve([0,10],[3,10],[4,9.5])), 
    arc_poly(arc([4,9.5],[4.4,8],[4,7.8])),
    arc_poly(arc([4,7.8],[3, 2],[7,0]))
); 

linear_extrude(height=8) flat_hanger(6, ramp, valley);
