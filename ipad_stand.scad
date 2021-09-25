e = .05;
overlap = .2;
t = 4;
h = 12;
cable_d = 4.5;
step = 51;
out = h;
lip_h = 16.5;
lip_w = 5;
hook_w = 9;
hook_depth = 7;
spine = 72;
phone_t = 12;
use <2d.scad>

module cable_punchout(){
    cable_r = cable_d / 2; 
    linear_extrude(height=2*e+t)
    polygon(points=concat(
       [[-cable_r,-e]], 
       arc_poly(arc([-cable_r,cable_r],[0,cable_d],[cable_r,cable_r])), 
       [[cable_r,-e]]));
}

module slot(){
    dx = t/2+e;
    linear_extrude(height=2*e+t)
    polygon(points=[[-dx,-e],[-dx,h/2+overlap],[dx,h/2+overlap],[dx,-e]]);
}

module punchouts(n_steps, same_side){
    c_step = step/4;
    union(){
        for(i=[0:n_steps]) 
            translate([out+t/2+(step)*i,0,-e]) slot();
        for(i=[0:n_steps-1]) {
            x=out+t/2+(step)*i;
            for(j=[1:3])
                translate([x + j*c_step ,same_side ? 0 : h ,-e]) 
                rotate([0,0,same_side ? 0 : 180]) 
                cable_punchout();
        }
    };
}

module bar(n_steps){
    difference(){
        linear_extrude(t)
            square([step*n_steps + t + 2*out, h], false);
        punchouts(n_steps, false);
    }

}

module stand(n_steps){
    top_hook=[hook_w,lip_h*2];
    bottom_hook = top_hook-[hook_depth,hook_depth];
    bottom_spine = bottom_hook + [phone_t*sqrt(2),0];
    top_spine = bottom_spine + [spine/sqrt(2),spine/sqrt(2)];
    landing=[top_spine[0],11];
    union(){
        difference(){
            linear_extrude(t)
                square([step*n_steps + t + 2*out, h], false);
            punchouts(n_steps, true);
        }

        linear_extrude(t)
        polygon(points=concat(
                [[0,0],[0,lip_h]],
                bc_poly(bezier_curve(triangle([-lip_w,lip_h],top_hook,height=-.8))),
                bc_poly(bezier_curve(triangle(bottom_hook,bottom_spine))),
                bc_poly(bezier_curve(triangle(top_spine,landing,.97,-.1))),
                bc_poly(bezier_curve(triangle(landing-[7,0],[18,11],1.3,1.8)))
                ));
    }
            
}

stand(2);

translate( [0, -20, 0] )
bar(2);

// difference(){
//     union(){
//         linear_extrude(height=d+s)
//             polygon(points=
//                 [[offset,r],[0,r],[-r,0],
//                 [-w2+offset,-h+r],[offset,-h+r]]
//                 );
//         linear_extrude(height=s)
//             polygon(points=concat(
//                 [[offset,c]],
//                 arc_poly(arc([0,c],[-c5*4,c5*3],[-c,0]),20),
//                 [[-w2+offset-b,-h+r],[offset,-h+r]])
//                 );
//     }
//     translate([0,0,-e]) cylinder(r=r, h=d+s+2*e, $fn=50);
// }