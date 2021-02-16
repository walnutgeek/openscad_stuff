$fn=100;
or=14;
ir=7.2;
ir2=10;
ir1=ir2-1.5;
l=93;
e=.01;
module c(z,l,r1,r2=-1){
    translate([0,0,z-l/2]) 
    if (r2 < 0)
        cylinder(l,r=r1,center=true);
    else
        cylinder(l,r1=r1, r2=r2, center=true);
}


difference(){
    union(){
        c(-e,l,or);
        intersection(){
            translate([0,-10,2]) rotate([45,0,0]) cube([20,10,10],center=true);
            translate([0,-10,2]) rotate([45,0,0]) translate([0,-6,0]) cylinder(20,r=11,center=true);
            c(10,20,or);
        }
    }
    union(){
        translate([0,10,-l/2]) cube([10,10,l+1],center=true);
        translate([0,21,11-l/2]) rotate([16,0,0]) cube([40,40,l-7.5],center=true);
        translate([0,-7,5]) rotate([16,0,0]) {
            translate([0,1.3,0]) cube([3,5,10],center=true);
            translate([0,-1.2,0]) cylinder(10,r=1.5,center=true);
            translate([0,-1.2,2]) cylinder(6,r=3.5,center=true);
        } 
        // cylinder(,r=17/2,center=true);
        // cylinder(,r=17/2,center=true);
        c(0,l-10+e,ir2);
        c(-l+10,5,ir1,ir2);
        c(0,l+2*e,ir);
    }
}