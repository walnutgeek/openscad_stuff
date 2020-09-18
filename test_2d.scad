x = 1; // [-10:0.1:10]
y = 5; // [-10:0.1:10]
steps = 10; // [5:100]

use <2d.scad>

module draw_line_segment(ls){
    t=.03;
    p_end = ls_endpoint(ls);
    color("Green") polygon(points=[ls[0]+[t,t],ls[0],p_end,p_end+[t,-t]]);
}

//-139.97	117.35	-40.0303
// echo (angle_diff_cw(-139.97,117.35), angle_diff_cw(117.35,-139.97));
// echo (angle_diff_cw(-139.97,-40.97), angle_diff_cw(-40.97,-139.97));
// echo (angle_diff_cw(-40.97,117.35), angle_diff_cw(117.35,-40.97));
// echo (angle_diff_ccw(-139.97,117.35), angle_diff_ccw(117.35,-139.97));
// echo (angle_diff_ccw(-139.97,-40.97), angle_diff_ccw(-40.97,-139.97));
// echo (angle_diff_ccw(-40.97,117.35), angle_diff_ccw(117.35,-40.97));
module test_arc( p1, p2, p3 ) { 
    color("Red") polygon(points=arc_poly(arc(p1,p2,p3), steps));
    polygon(points=[p1,p2,p3]);
}

test_arc([0,0],[x,y],[5,0]);
