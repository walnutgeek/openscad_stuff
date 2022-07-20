use <Screws.scad>
wing=12;
depth=5;
h=20;
sink=2.;
e=.01;
d_hat = s1_25()[6];
$fn =50;

x = wing-d_hat/2 + e;
y = 2 * depth + e;
diag = sqrt(x*x + y*y);
y_angle = atan(y/x);
echo(x,y,diag, y_angle);
difference(){
    translate([-wing,-depth,0]) 
        cube([2*wing,2*depth,h]);
    translate([0,0,sink-e]) 
        screw(s1_25(),sink+2*e);
    translate([-wing,-depth,-e]) 
        rotate([0,0,y_angle])
           cube([diag,diag/2,h+2*e]);
    translate([wing-x,depth,-e]) 
        rotate([0,0,-y_angle])
           cube([diag,diag/2,h+2*e]);
    
}



