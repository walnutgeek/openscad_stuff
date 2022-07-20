use <Screws.scad>
wing=15;
depth=5;
r=7.1;
trap=5;
adj=1.5;
h=20;
sink=2.;
e=.01;
d_hat = s1_25()[6];

y_cir = depth+r-adj;

x = wing-d_hat/2 + e;
y = 2 * depth + e;
diag = sqrt(x*x + y*y);
y_angle = atan(y/x);
$fn =50;

difference(){
    translate([-wing,-depth-trap,0]) 
        cube([2*wing,2*depth+trap,h]);
    
    translate([r,-y_cir,-e]) 
        cylinder(r1=r,r2=r,h=h+2*e);
    translate([r,-y_cir,-e]) 
        cube([wing-r+e,r,h+2*e]);
    
    translate([-r,-y_cir,-e]) 
        cylinder(r1=r,r2=r,h=h+2*e);
    translate([-wing-e,-y_cir,-e]) 
        cube([wing-r+e,r,h+2*e]);
    
    translate([0,0,sink-e]) 
        screw(s1_25(),sink+2*e);
    translate([-wing,-depth,-e]) 
        rotate([0,0,y_angle])
           cube([diag,diag/2,h+2*e]);
    translate([wing-x,depth,-e]) 
        rotate([0,0,-y_angle])
           cube([diag,diag/2,h+2*e]);
    
}



