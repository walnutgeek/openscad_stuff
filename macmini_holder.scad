r = 35;
h = 40;
hole = 2.5;
countersink = 5;
e=.1;
$fn=100;
difference(){
        cylinder(r=10, h=h);
        translate([0,0,-e]){
            cylinder(r=hole, h=h+e+e);
            cylinder(countersink, countersink, 0);
        };
        translate([-28, -28, 3]) 
            cylinder(r=r, h=h );
}

