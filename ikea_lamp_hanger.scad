cleat = 3.5;
base = 20;
e=.01;
y_cut=2;
x_cut=6.8;
y=32+y_cut;
x=23;
cut=y_cut;
w=30;

use <Screws.scad>
use <2d.scad>

difference(){
    union(){
        cube([w,y,cleat],center=true);
        translate([0,0,cleat/2+base/2-e]) 
        cube([x,y,base],center=true);
    }
    translate([0,3-x/2,3])
        rotate([0,-90,0]) 
        linear_extrude(height=x+e, center=true)
            polygon(points=concat(
            bc_poly(bezier_curve([0,y],[0,-10],[x,0])),
            [[x,y]])
            );

    #translate([0,-9,12]) rotate([90,0,0]) screw(s1_25(),8);

    translate([0,y_cut/2-y/2-e,x/2-cleat/2+x_cut]) 
      cube([w+e,y_cut,x],center=true);
}