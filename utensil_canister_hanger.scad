e=.01;

canister1 = [2,126,1,50,120];
canister2 = [0,120,5,50,119];
$fn=100;


module negative(can) {
    l1=can[0]; d1=can[1]; s=can[2]; l2=can[3]; d2=can[4];
    d0 = d1 - 2;
    union(){
        translate([0,0,(-l2+e)/2]) cylinder(h=l2, d1=d0, d2=d0, center=true);
        cylinder(h=l1, d1=d1, d2=d1, center=true);
        translate([0,0,(l1+s-e)/2]) cylinder(h=s, d1=d1, d2=d2, center=true);
        translate([0,0,l1+s+(l2-2*e)/2]) cylinder(h=l2, d1=d2, d2=d2, center=true);
    }
}

module hanger(can){
    l1=can[0]; d1=can[1]; s=can[2]; l2=can[3]; d2=can[4];
    sum=l1+s+l2+2-3*e;
    echo(sum);
    difference(){
        translate([d1/2-5,0, sum/2-2])
        cube([20,50,sum],center=true);
        negative(can);
    }
}

hanger(canister2);