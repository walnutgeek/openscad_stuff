h = 22.3;
d = 15.8;
$fn=100;
w_lip = .25;
h_lip = 2;
h_cut = 5;
e=.01;

use <Screws.scad>


difference(){

    union(){
        cylinder(h,d1=d,d2=d);
        translate([0,0,h-e])
            cylinder(h_lip,d1=d+w_lip,d2=d+w_lip);
    }
    
    translate([0,0,h]) rotate([180,0,0]) screw(s1_25(),5);
    
    translate([0,0,h+h_lip-h_cut+e])
    union(){
        for (i = [0:3]){
            rotate([0,0,i*90]) translate([-1,0,0]) cube([2,d,h_cut]);
        }
    }

}
