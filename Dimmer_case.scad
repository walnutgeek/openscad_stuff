
l=81;
h=22;
w=41;
t = 3;
c = 12;
e = .01;

module countersink(hole_d,hole_h, screw_d,screw_h){
    hh = hole_h - screw_h ;
    union(){
        cylinder(d=hole_d,h=hh+e,$fn=50);
        translate([0,0,hh]) cylinder(d1=hole_d, d2=screw_d,h=screw_h,$fn=50);
    }
}

difference(){
    cube([w+t*2,l+t*2,h+t+.5], center=true);
       
    union(){
        translate([0,0,t+1])
        cube([w-1.5,l,h], center=true);
        cube([w,l,h], center=true);
        translate([0,2*t,t])
        cube([c,l,h], center=true);
        for ( i =[1,-1]){
            translate([0,i * l/3,t/2-h+.5])
            countersink(3, 10, 8,2 );
            
        }
    }
}

