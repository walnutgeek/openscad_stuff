N = 21;
d = 18.5;
gap = 1.4;
angle = 44 ;
lip = .7;
e = .05;

hook_sy = 2 ;
hook_by = 3 ;
hook_dx = 2;

cc = d/2 + gap;
start = [cc, cc];
step_x = (d + gap)*sin(angle);
step_y = (d + gap)*cos(angle);


module holder(n_cells,left_side) {
    rect = [ start[0]*2 + (n_cells-1)*step_x, start[1]*2+step_y, 4 ];
    echo(rect);
    cut2_x = rect[0]/2 ;
    cut1_x = cut2_x+step_x ;
    c1_y = cc;
    c2_y = rect[1] - cc;
    
    module lattice(){
        difference(){
            cube( rect );
            for( i = [0:n_cells-1] ) 
                cell_hole(start + [ step_x * i, step_y*(i%2)]);
        }
    }
    module cutout(y,q){
        linear_extrude(5)
        polygon([
            [y+q, -e],
            [-q+cut1_x, -e],
            [-q+cut1_x,          q+c1_y-hook_sy],
            [-q+cut1_x+hook_dx,  q+c1_y-hook_by],
            [-q+cut1_x+hook_dx, -q+c1_y+hook_by],
            [-q+cut1_x,         -q+c1_y+hook_sy],
            [-q+cut1_x, c2_y],
            [-q+cut2_x,         -q+c2_y-hook_sy],
            [-q+cut2_x-hook_dx, -q+c2_y-hook_by],
            [-q+cut2_x-hook_dx,  q+c2_y+hook_by],
            [-q+cut2_x,          q+c2_y+hook_sy],
            [-q+cut2_x, rect[1]+e],
            [y+q, rect[1]+e],
            ]);
    }

    translate([left_side ? 0: -cut2_x ,0,0]) difference(){
        lattice();
        translate([0,0,-e]) cutout(left_side ? rect[0] : 0, left_side ? e : -e);
    }
}

module cell_hole(xy){
    union(){
        r1 = d/2;
        r2 = r1 - 1.5* lip ;
        translate( [xy[0], xy[1], lip]) 
            cylinder ( 5, r1, r1 );
        translate( [xy[0], xy[1], -e]) 
            cylinder ( 5, r2, r2 );
    }
}

holder(N, true);
translate([0,40,0]) holder(N, false);