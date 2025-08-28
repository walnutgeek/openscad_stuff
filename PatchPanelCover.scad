w = 105;

w_sides = 6;
d = 43;
h_extended = 11;
h = 23+h_extended;
t = 3;


k = 16.5;
k2 = w - 2*w_sides ;//92.7;

h1 = h - 16.2;
h2 = 9.1 + +h_extended;



r = 1;

x = 2;

$fn = 100;
e = .01;

use <Screws.scad>

difference(){
    union(){
        cube(size = [w, d+2*t, h], center= true);
        for (ix=[1, -1]) {
            for (iy=[1, -1]) {
                translate([iy*w/2, ix*(d+t)/2, -h/2])
                    rotate([0,-90,-iy*90])
                        linear_extrude(height = t, center=true)
                            polygon([[h,h],[h,0-e],[0,0-e]]);
                translate([iy*(h*sqrt(2)+w)/2, ix*(d+t)/2, (h-10)/2])
                    rotate([0,0,45])
                    cylinder( h=10, r1=0, r2=10*sqrt(2),center=true, $fn=4);
                
            }
        }
    
    }
    union(){
        for (i=[.5,-.5]) {
            translate([(w-w_sides-1)*i, 0, 0])
                cylinder(h+e, r, r, center=true);
        }

                
        translate([0, 0, (h-h1)/2])
            cube(size = [w+e, d, h1+e], center= true);

        translate([0, 0, t/2])
            cube(size = [k2, d-2*t, h-t+e], center= true);


        for (i=[1, -1]) {
            translate([0, i*(d-t)/2, (h-h2)/2])
                cube(size = [w+e, t, h2+e], center= true);
        }
        
        translate([0, x/2, 0])
            cube(size = [k2, k, h+e], center= true);

        for (ix=[1, -1]) {
            for (iy=[1, -1]) {
                translate([iy*(w+h+15)/2, ix*(d+t+13)/2, (-8-e+h)/2])
                    rotate([0,ix*-45,90])
                    screw(s1_25());
            }}
    
    }
}




