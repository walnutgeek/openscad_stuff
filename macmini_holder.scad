r = 35;
h = 40.5;
hole = 2.5;
countersink = 5;
e=.1;
off=7-r;
$fn=100;
difference(){
        cylinder(r=10, h=h);
        translate([0,0,-e]){
            cylinder(r=hole, h=h+e+e);
            cylinder(countersink, countersink, 0);
        };
        translate([off, off, 3]) 
            cylinder(r=r, h=h );
}

