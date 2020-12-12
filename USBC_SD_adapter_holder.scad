w=97.2/2;
d=30/2;
r=4; //roundover
o=2; //outside
h=10.8;
l=1;
s=10;
e=0.01;

use <2d.scad>

dm = d-r;
wm = w-r;

corner = bc_poly(bezier_curve([w,dm],[w,d],[wm,d]));

in_poly = concat(
    symmetry_y(corner),
    corner,
    symmetry_x(corner),
    symmetry_x(symmetry_y(corner))
);

module countersink(hole_d,hole_h,screw_d){
    screw_h = screw_d - hole_d;
    h = hole_h - screw_h ;
    union(){
        cylinder(d=hole_d,h=h+e,$fn=50);
        translate([0,0,h]) cylinder(d1=hole_d, d2=screw_d,h=screw_h,$fn=50);
    }
}
difference (){
    linear_extrude(height=o*2+h)
        polygon(points=scale_poly(in_poly,[1+o/w, 1+o/d]));
    union(){
        translate([0,0,o]) 
            linear_extrude(height=h) polygon(points=in_poly);
        translate([0,0,o+h-e]) 
            linear_extrude(height=o*2)
                polygon(points=scale_poly(in_poly,[1-l/w, 1]));
        translate([0, 0, o+h/2])
            cube([3*w, 2*dm, h-2*l],center=true);
        translate([0, d, o+h])
            cube([2*wm, 4*d, 2*h],center=true);
        // screw holes
        translate([w/2,-d-5+e,o+h/2]) 
            rotate([-90,0,0]) countersink(2.5,5,5);
        translate([-w/2,-d-5+e,o+h/2]) 
            rotate([-90,0,0]) countersink(2.5,5,5);
        

    }
}
