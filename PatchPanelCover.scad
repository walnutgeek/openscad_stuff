w = 106;

w_sides = 6;
d = 43;
h = 23;
t = 3;


k = 16.5;
k2 = w - 2*w_sides ;//92.7;

h1 = h - 16.2;
h2 = 9.1;



r = 1;

x1 = 18.8;
x2 = 16.9;

$fn=100;
e=.01;

difference(){
    cube(size = [w, d+2*t, h], center= true);
    union(){
        for (i=[.5,-.5]) {
            translate([(w-w_sides)*i,0,0])
            cylinder(h+e, r, r, center=true);
        }

                
        translate([0,0,(h-h1)/2])
        cube(size = [w+e, d, h1+e], center= true);

        translate([0,0,t/2])
        cube(size = [k2, d-2*t, h-t+e], center= true);


        for (i=[1,-1]) {
            translate([0,i*(d-t)/2,(h-h2)/2])
            cube(size = [w+e, t, h2+e], center= true);
        }
        
        translate([0,(x1-x2)/2,0])
        cube(size = [k2, k, h+e], center= true);
        
        
    }
}




