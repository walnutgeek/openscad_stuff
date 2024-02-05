use <2d.scad>

d = 18.5;
h_gap = 1.75;
v_gap = 2.5;
n = 3;


base_w=9;
hole_w=5;
hole_d=2;

total_d = (h_gap+d)*n;
hole_offset = total_d/2-3;

e=.05;

module bms_holder(){
    step = h_gap + d;
    module hole(){
        cube([hole_d,(v_gap+e)*2,hole_w], center=true);
    }
    module negative(){
        module cell(){
            cylinder(h=base_w+2*e, d=d, center=true);
        }
        //TODO loop by `n`
        translate([0,0,0] ) cell();
        translate([step,0,0] ) cell();
        translate([-step,0,0] ) cell();
        
    }
    difference(){
        cube([total_d,v_gap*2,base_w], center=true);
        translate([0,d/2,0]) negative();
        translate([hole_offset,0,0] ) hole();
        translate([-hole_offset,0,0] ) hole();
    }
}


for (i=[0:3])
   translate([0,0,i*10])
     bms_holder();

