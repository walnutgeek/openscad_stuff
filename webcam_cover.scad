a=23.3;          // body size 

lw = 20;         // lens width
l34 = lw * .75 ; // 3/4 th
l2 = lw /2 ;     // half
ld = 2 ;         // lens depth

t = 4;
e = .01;

ch = a-15.5;
cw = lw*3;
cd = a+t;

use <2d.scad>

half=concat(
    bc_poly(bezier_curve([0,-t],[lw,-t],[lw,0])),
    bc_poly(bezier_curve([lw,0],[lw,a/2],[l34,a/2])),
    bc_poly(bezier_curve([l34,a/2],[l2,a/2],[l2,a])),
    bc_poly(bezier_curve([l2,a],[l2,a+t],[0,a+t]))
);

difference(){
    linear_extrude(height=cd)
        polygon(points=concat(half, mirror_x(half))); // main shape
    translate([0,a/2,a/2-e]) 
        cube(size=[cw, a, a], center=true);  // webcam body recess
    translate([0, -ld/2+e, a/2-e]) 
        cube(size=[lw,ld,a], center=true);   // lens cavity
    translate([0,cd/2,ch/2-e]) 
        cube(size=[cw,cd,ch], center=true);  // back cut
};
    