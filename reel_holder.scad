p=2;
c=28.5;
hole=16;
e=.1;
gap = 8;

use <2d.scad>

module countersink(hole_d,hole_h,screw_d){
    screw_h = screw_d - hole_d;
    h = hole_h - screw_h ;
    union(){
        cylinder(d=hole_d,h=h+e,$fn=50);
        translate([0,0,h]) cylinder(d1=hole_d, d2=screw_d,h=screw_h,$fn=50);
    }
}

difference() {
    union(){
        linear_extrude(height=p) {
            circle(r=10);
            polygon(points=concat([[10,0]],
            bc_poly(bezier_curve([30,25],[30,30],[25,30])),
            bc_poly(bezier_curve([-24,30],[-35,30],[-30,15])),
            bc_poly(bezier_curve([-30,15],[-28,10],[-40,6])),
            [[-40,0]]));
        }
        translate([0,0,p]) cylinder(d=19.5, h=c);
        translate([0,0,p+c]) cylinder(d1=19.5,d2=20.2, h=1);
        translate([0,0,p+c+1]) cylinder(d2=19.5,d1=20.2, h=1);
        translate([-40,0,p]) cube([2,6,10]);
    }
    translate([0,0,-e])cylinder(d=hole, h=c+p+2+e+e);
    translate([0,0,c-3]) cube([gap,50,hole],center=true);
    translate([0,0,c-3]) cube([50,gap,hole],center=true);
    translate([-40-e,2,p]) cube([2+e+e,2,8]);
    translate([25,25,-e]) countersink(3, p+e+e, 4.5);
    translate([-25,25,-e]) countersink(3, p+e+e, 4.5);

}
