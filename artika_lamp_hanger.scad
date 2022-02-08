angle = 10;
e=.01;

use <Screws.scad>
use <2d.scad>

module base(){
    w = 28;
    l = 33;
    thick = 9;
    recess = 1;
    pad = 4 ;
    support = 12;
    ww = w + pad;
    ll = l + pad;
    tre = thick-recess+e;
    union(){
        difference(){
            translate([-pad,-ww/2,0]) cube([ll+pad,ww,thick]);
            translate([0,-w/2,tre]) cube([ll,w,recess]);
            translate([l,0,tre]) rotate([0,180,0]) screw(a10x0x2x2x6mm(),3);
        }
        translate([0,-ww/2,-l+e]) cube([support,ww,l]);
    }
      
}

rotate([0,-90,0])
difference(){
    rotate([0,angle,0]) base();
    translate([-25,0,0]) cube([50,50,100],center=true);
    #translate([8,0,-15]) rotate([0,-90,0]) screw(s2(),3);
}
