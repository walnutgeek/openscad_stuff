w = 6;
d = 42;
h = 23;
t = 3;


k = 16.3;
h2 = 9.1;

r = 1/2;

x1 = 18.8;
x2 = 16.9;

$fn=100;
e=.01;

difference(){
    translate([.5,0,0])
    cube(size = [w+1, d+2*t, h], center= true);
    union(){
        cylinder(h+e, r, r, center=true);
        
        translate([.5,0,(h-h2)/2])
        cube(size = [w+1+e, d, h2+e], center= true);
        
        translate([3+k/2,(x1-x2)/2,0])
        cube(size = [k, k, h+e], center= true);
        
        
    }
}




