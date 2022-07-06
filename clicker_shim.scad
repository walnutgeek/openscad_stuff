use <2d.scad>

ramp = bc_poly(bezier_curve([0,17],[0,7],[25,0]));
m1 = [[0,0],[-5,8.5],[0,17]];
m2 =[[-17,0],[-19,5],[-17,10]];

h1 = 17;
h2 = 47;
h3 = 12;
e=.01;
q=1.5;

function addnz(xy,s) = [for (p = xy) sign(p)*s+p];
function bump(poly,s=2) = [for (xy = poly) addnz(xy,s)];

b1 = bump(m1);
b2 = bump(m2);

a = 17;
translate([0,0,e-q]) 
linear_extrude(height=q) 
    polygon(points=concat( ramp, b2 ));

linear_extrude(height=h1) 
    polygon(points=concat( ramp, m2 ));

diff=concat( [[-40,0]], b2, [b2[2]+[5,10], b2[2]+[-5,20]] );

function shift_y_by_e(poly) = [ for (xy = poly) [xy[0],xy[1]-e] ];

translate([0,0,h1-e]) 
    difference(){
        linear_extrude(height=h2+2*e) 
            polygon(points=concat( ramp, b2 ));
        rotate([0,a,0])
        translate([0,0,sin(a)*-17])
        linear_extrude(height=h2/cos(a)) 
            polygon(points=shift_y_by_e(diff));
        }

translate([0,0,h2+h1]) 
    linear_extrude(height=12) 
        polygon(points=concat( ramp, m1 ));

translate([0,0,h2+h1+h3-e]) 
    linear_extrude(height=q) 
        polygon(points=concat( ramp, b1 ));
