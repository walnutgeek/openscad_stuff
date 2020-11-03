e = 1;
r = 5.2;
b = 2; //border
c = r+b;
c5 = c/5;
w1 = 38.25;
w2 = 41.25;
h = 19;
d = 8;
s = 4; // spacer
offset=w1-r;
use <2d.scad>

difference(){
    union(){
        linear_extrude(height=d+s)
            polygon(points=
                [[offset,r],[0,r],[-r,0],
                [-w2+offset,-h+r],[offset,-h+r]]
                );
        linear_extrude(height=s)
            polygon(points=concat(
                [[offset,c]],
                arc_poly(arc([0,c],[-c5*4,c5*3],[-c,0]),20),
                [[-w2+offset-b,-h+r],[offset,-h+r]])
                );
    }
    translate([0,0,-e]) cylinder(r=r, h=d+s+2*e, $fn=50);
}