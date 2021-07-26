use <2d.scad>

base_w=111.5;
h = 15;


module bms_holder(w){
    e=.05;
    d114 = 42.2; // OD: 1 1/4"
    d1 = 32.5; // OD: 1"
    d = d1;   
    ratio = d/d114;
    t=3.5;

    pilot_holes_w = 73;

    // pcb_thick = 2.5;
    // pcb_width = 55.3;

    origin = [0,0];
    thickness = [0,t];
    spacer = [3,0];
    outer_end = [w/2,0];
    outer_down=outer_end-thickness;
    down_arc = outer_down-[d,d]/2;
    down_arc_t = down_arc-[2,0];

    halfback = concat( [origin, outer_end] , 
                arc_poly(arc(triangle(outer_end+spacer, outer_down+spacer,height=-.5))),
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

    module holes(zign){
        union(){
            translate([(outer_end[0])*zign,-screw_len-.5,h/2]) 
            rotate([-90,0,0]) 
            countersink(2.5,screw_len,6,2.3);
            translate([pilot_holes_w/2*zign,-screw_len+e,h/2]) 
            rotate([-90,0,0]) 
            cylinder(d=1,h=screw_len+e,$fn=50);
        }
    }

    difference(){
        linear_extrude(height=h)
        polygon(points=concat(halfback, symmetry_x(halfback)));
        union(){
            //translate([0,-t-pcb_thick/2,0])
            //cube([pcb_width, pcb_thick, 10 ], center=true);
            holes(1);
            holes(-1);
        }
    }

}


bms_holder(base_w+.5);

translate([0,0,h*1.5])
bms_holder(base_w+4.5);

translate([0,0,h*3])
bms_holder(base_w+5);

