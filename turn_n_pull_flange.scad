e = .1;

module doughnut(hole_r, out_r, h, n_screw, screw_p, screw_d, init_angle){
    difference(){
        cylinder(d=out_r*2, h=h, $fn=100);
        union(){
            translate([0,0,-e]) cylinder(d=hole_r*2, h=h+2*e,$fn=100);
            angle_step = 360/n_screw;
            for( i = [0:n_screw-1] ) {
                a = init_angle + angle_step*i ;
                translate([screw_p*sin(a),screw_p*cos(a),-e]) 
                  cylinder(d=screw_d, h=h+2*e,$fn=100);
            }
        }
    }
}

//         hole_r, out_r, h, n_screw, screw_p,                screw_d, init_angle){
translate([-42,0,0]) 
    doughnut(56/2, 80/2,  1, 2,       68.76/2,                4,       0);
translate([42,0,0]) 
    doughnut(56/2, 80/2,  1, 3,       79.16/2 - 2.8 - 4.72/2, 4,       90);