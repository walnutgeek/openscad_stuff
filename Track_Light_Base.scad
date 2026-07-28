$fn=100;
difference(){
    union(){
       cylinder(h = 10, d =136, center=true);
       translate([0,0,1])
       cylinder(h = 8, d =141, center=true);
    }
    cylinder(h = 10.2, d =132, center=true);
    translate([0,50,3]) cube([9,100,4.1], center=true);
}
