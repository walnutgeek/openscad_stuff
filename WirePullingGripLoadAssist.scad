$fn=100;
e=.01;
difference(){
    translate([0,0,e-25/2]) cylinder(25,r=12,center=true);
    union(){
        translate([0,10,0])
        cube([10,10,50],center=true);
        cylinder(40,r=17/2,center=true);
        cylinder(50,r=14.5/2,center=true);
    }
}