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

//         hole_r, out_r, h, n_screw, screw_p,  screw_d, init_angle){
translate([-42,0,0]) 
    doughnut(58/2, 80/2,  2, 2,       69/2,     5,       0);
translate([42,0,0]) 
    doughnut(58/2, 80/2,  2, 3,       34.6,     5,       90);