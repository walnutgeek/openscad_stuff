$fn=100;
outer=146;
lip=139;
hole=132;

difference(){
    union(){
       cylinder(h = 10, d=lip, center=true);
       translate([0,0,1])
       cylinder(h = 8, d=outer, center=true);
    }
    cylinder(h = 10.2, d =hole, center=true);
    translate([0,50,3.6]) cube([7,100,3.5], center=true);
}
