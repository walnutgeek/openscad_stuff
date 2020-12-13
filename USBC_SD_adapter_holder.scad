w=98/2;
d=30/2;
r=4; //roundover
o=2; //outside
h=10.8;
l=1;
s=10;
e=0.01;
m=5;
v=2.3; //releaf param

use <2d.scad>

dm = d-r;
wm = w-r;

c = 6; // Screw top diameter
corner = bc_poly(bezier_curve([w,dm],[w,d],[wm,d]));

in_poly = concat(
    symmetry_y(corner),
    corner,
    symmetry_x(corner),
    symmetry_x(symmetry_y(corner))
);

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
        translate([ww/2,-d-5+e,o+h/2]) 
            rotate([-90,0,0]) countersink(2.5,5,c,2.3);
        //relave
        translate([ww*.8,-d-5+e,h]) 
            rotate([-90,0,0])
            linear_extrude(height=10) 
            polygon(concat([[v,-5]],arc_poly(arc([v,0],[0,7],[-v,0]),15),[[-v,-5]]));
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
        translate([0,0,-e]) 
            linear_extrude(height=o+2*e)
                polygon(points=scale_poly(in_poly,[1-m/w, 1-m/d]));
        translate([0, 0, o+h/2])
            cube([3*w, 2*dm, h-2*l],center=true);
        translate([0, d, o+h])
            cube([2*wm, 4*d, 2*h],center=true);
        backwall_alterations(w);
        backwall_alterations(-w);
    }
}
