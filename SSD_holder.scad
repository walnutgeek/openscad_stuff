
w=112.5;
d=44.2;
h=15;
o=2; //outside
l=1;
e=0.01;

use <vector.scad>
use <2d.scad>


module countersink(hole_d,hole_h, screw_d,screw_h){
    h = hole_h - screw_h ;
    union(){
        cylinder(d=hole_d,h=h+e,$fn=50);
        translate([0,0,h]) cylinder(d1=hole_d, d2=screw_d,h=screw_h,$fn=50);
    }
}

module backwall_alterations(ww)
    union(){
        // screw hole
        #translate([ww/4,-d/2-5+e,0]) 
            rotate([-90,0,0]) countersink(2.5,5,6,2.3);
    }

box = [w,d,h];
box_with_walls = v_add(box, 2*o);

module hatchbox(w1, w2, dd, hh){
    x1 = w1/2;
    x2 = w2/2;
    y = dd/2;
    translate( [0,0,-hh/2] )
    linear_extrude(height=hh) 
        polygon(points=[[x1,y],[-x1,y],[-x2,-y],[x2,-y]]);
}

difference (){
    cube(box_with_walls, center=true);
    union(){
        cube(box, center=true);
        translate([0,d/2,o*3])
        cube( v_add(box_with_walls,e), center=true);
        translate([0, 0, o+l]) rotate([-90, 0, 90]) 
            hatchbox(d-6,d,h+o+l,w+3*o);
        translate([0, 3*o, 0]) 
            hatchbox(w-4,w-15,d,h+3*o);
        backwall_alterations(w);
        backwall_alterations(-w);
    }
}
