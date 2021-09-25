e = .01;
t = 4;
h = 12;
cable_d = 4.5;
step = 51;
out = h;
lip_h = 16.5;
spine = 72;
phone_t = 12;

use <2d.scad>

module cable_punchout(){
    cable_r = cable_d / 2; 
    linear_extrude(height=2*e+t)
    polygon(points=concat(
       [[-cable_r,-e]], 
       arc_poly(arc([-cable_r,cable_r],[0,cable_d],[cable_r,cable_r])), 
       [[cable_r,-e]]));
}

module slot(){
    dx = t/2+e;
    linear_extrude(height=2*e+t)
    polygon(points=[[-dx,-e],[-dx,h/2],[dx,h/2],[dx,-e]]);
}

module bar(n_steps){
    c_step = step/4;
    difference(){
        linear_extrude(t)
            square([step*n_steps + t + 2*out, h], false);
        for(i=[0:n_steps]) 
            translate([out+t/2+(step)*i,0,-e]) slot();
        for(i=[0:n_steps-1]) {
            x=out+t/2+(step)*i;
            for(j=[1:3])
                translate([x + j*c_step ,h ,-e]) rotate([0,0,180]) cable_punchout();
        }
    }
}

bar(2);
// difference(){
//     union(){
//         linear_extrude(height=d+s)
//             polygon(points=
//                 [[offset,r],[0,r],[-r,0],
//                 [-w2+offset,-h+r],[offset,-h+r]]
//                 );
//         linear_extrude(height=s)
//             polygon(points=concat(
//                 [[offset,c]],
//                 arc_poly(arc([0,c],[-c5*4,c5*3],[-c,0]),20),
//                 [[-w2+offset-b,-h+r],[offset,-h+r]])
//                 );
//     }
//     translate([0,0,-e]) cylinder(r=r, h=d+s+2*e, $fn=50);
// }