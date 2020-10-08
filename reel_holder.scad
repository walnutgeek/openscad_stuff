reelD=19.5;
p=3;
c=28.5;
hole=16;
e=.01;
gap = 8;
dispX = -40;
dispY = -10;
lipH = 1.2;
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
            bc_poly(bezier_curve([-30,15],[-28,10],[-40,-4])),
            [[dispX,dispY]],
            bc_poly(bezier_curve([dispX+p,dispY],[-15,0],[-6,-8]))
            ));
        }
        translate([0,0,p]) cylinder(d=reelD, h=c);
        translate([0,0,p+c]) cylinder(d1=reelD,d2=reelD+lipH, h=lipH);
        translate([0,0,p+c+lipH]) cylinder(d2=reelD,d1=reelD+lipH, h=lipH);
        translate([dispX,dispY,p]) cube([p,6,10]);
    }
    translate([0,0,-e])cylinder(d=hole, h=c+p+2*lipH+e+e);
    translate([0,0,p+c+2*lipH-hole/2+e]) cube([gap,50,hole],center=true);
    translate([0,0,p+c+2*lipH-hole/2+e]) cube([50,gap,hole],center=true);
    translate([dispX-e,dispY+2,p]) cube([p+e+e,2,8]);
    translate([25,25,-e]) countersink(3, p+e+e, 4.5);
    translate([-25,25,-e]) countersink(3, p+e+e, 4.5);

}
