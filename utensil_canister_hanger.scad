e=.01;
d_screw = 2;
spread_angle = 12;
w_plate = 50;
off=10;
canister1 = [2,126,1,w_plate,120];
canister2 = [0,120,5,w_plate,119];
$fn=200;


module negative(can) {
    l1=can[0]; d1=can[1]; s=can[2]; l2=can[3]; d2=can[4];
    d0 = d1 - 2;
    union(){
        translate([0,0,(-l2+e)/2]) cylinder(h=l2, d1=d0, d2=d0, center=true);
        cylinder(h=l1, d1=d1, d2=d1, center=true);
        translate([0,0,(l1+s-e)/2]) cylinder(h=s, d1=d1, d2=d2, center=true);
        translate([0,0,s+(l1+l2-2*e)/2]) cylinder(h=l2, d1=d2, d2=d2, center=true);
    }
}

module screw_hole(can){
    l1=can[0]; d1=can[1]; s=can[2]; l2=can[3]; d2=can[4];
    rotate([0,90,0]) cylinder(h=max(d1,d2)*2.5,d1=d_screw,d2=d_screw,center=true);
}

module hanger(can){
    l1=can[0]; d1=can[1]; s=can[2]; l2=can[3]; d2=can[4];
    sum=l1+s+l2-3*e;
    difference(){
        translate([d1/2-5,0, sum/2-2])
        cube([20,w_plate,sum],center=true);
        negative(can);
        translate([0,0,off]) screw_hole(can);
        rotate([0,0,spread_angle]) translate([0,0,w_plate-off]) screw_hole(can);
        rotate([0,0,-spread_angle]) translate([0,0,w_plate-off]) screw_hole(can);
    }
}

hanger(canister1);
// hanger(canister2);