a=33.3/2;
b=63.4/2;
w=1;
r=9;
h=6;
$fn=100;
use <2d.scad>
corner = concat(
    bc_poly(bezier_curve([a,0],[a,(b-r)/2],[a-.5,b-r])), 
    bc_poly(bezier_curve([a-.5,b-r],[a-.5,b],[a-.5-r,b]))
); 
in_poly = concat(
    symmetry_y(corner),
    corner,
    symmetry_x(corner),
    symmetry_x(symmetry_y(corner))
);
out_poly = scale_poly(in_poly,[1+w/a, 1+w/b]);
n = len(in_poly);

translate([0,0,h])
linear_extrude(height=100, scale=[1,2], slices=20, twist=90)
polygon(points=concat(out_poly,in_poly),
        paths=[ [for(i=[0:n-1])i], [for(i=[n:2*n-1])i] ]);

linear_extrude(height=h)
polygon(points=concat(out_poly,in_poly),
        paths=[ [for(i=[0:n-1])i], [for(i=[n:2*n-1])i] ]);
