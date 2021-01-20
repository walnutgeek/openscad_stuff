use <2d.scad>
e=.05;
d114 = 42.2; // OD: 1 1/4"
d1 = 32.5; // OD: 1"
d = d1;   
ratio = d/d114;
t=3.5;
w=111.5;
h = 15;

origin = [0,0];
thickness = [0,t];
outer_end = [w/2,0];
outer_down=outer_end-thickness;
down_arc = outer_down-[d,d]/2;
down_arc_t = down_arc-[2,0];

halfback = concat( [origin, outer_end] , 
            arc_poly(arc(triangle(outer_end, outer_down,height=-.5))),
            arc_poly(arc(triangle(outer_down, down_arc,height=(sqrt(2)-1)/2))),
            arc_poly(arc(triangle(down_arc, down_arc_t,height=-.5))),
            bc_poly(bezier_curve(triangle(down_arc_t, origin-thickness,.7/ratio, .51*ratio)))
        );

module countersink(hole_d, hole_h, screw_d, screw_h){
    h = hole_h - screw_h ;
    union(){
        cylinder(d=hole_d,h=h+e,$fn=50);
        translate([0,0,h]) cylinder(d1=hole_d, d2=screw_d,h=screw_h,$fn=50);
        translate([0,0,hole_h-e]) cylinder(d=screw_d,h=2,$fn=50);
    }
}

screw_len = 5;

module screw(zign){
         translate([(down_arc_t[0]+screw_len-e)*zign,down_arc_t[1]+3,h/2]) 
         rotate([90,0,zign*-90])
             countersink(2.5,screw_len,6,2.3);
}

difference(){
    linear_extrude(height=h)
    polygon(points=concat(halfback, symmetry_x(halfback)));
    union(){
         screw(1);
         screw(-1);
    }
}



