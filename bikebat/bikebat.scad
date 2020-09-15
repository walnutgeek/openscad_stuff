distance =  19.35;
dx = cos(60) * distance;
dy = sin(60) * distance;
r = 18/2;
h = 2;

function coord_row(count, dx, dy) = [for ( i = [ 0:count-1]) [dx-i*distance, dy]];

YYXX = [ 
    coord_row( 14, -2*dx, 2*dy),
    coord_row( 15, -dx, dy),
    coord_row( 15, 0, 0),
    coord_row( 15, -dx, -dy),
    coord_row( 11, -2*dx, -2*dy),
];


for ( row = YYXX ){
    for( bat = row ){
        translate( [bat[0],bat[1],0]) 
            color("Grey", .1) cylinder(r=r, h=h, center=true);
    }
}

module tab(top,poly, positive, shift_x=0){
    if(top){
        zc_tab(h/2+2, "Blue", poly, positive, shift_x);
    }else{
        zc_tab(-(h/2+2), "Red", poly, positive, shift_x);
    }
}

module zc_tab(z, c, poly, positive, shift_x){
    shift=[shift_x,0];
    abs_z = abs(z);
    sign_z = abs_z == z ? 1 : -1;
    plus_z = z + sign_z * 2;
    minus_z = plus_z - (z+2*sign_z)*2;
    color(c) union(){
        for ( i = [0:len(poly)-2]){
            xxyy1 = poly[i] + shift;
            xxyy2 = poly[i+1] + shift;
            xy1 = YYXX[xxyy1[1]][xxyy1[0]];
            xy2 = YYXX[xxyy2[1]][xxyy2[0]];
            dxy = xy2 - xy1;
            for( dd = [0:.05:1]){
                translate( [xy1[0]+dxy[0]*dd, xy1[1]+dxy[1]*dd, z] ) 
                circle(5);
            }
        }
    }
    for( xxyy = positive){
        sxxyy = xxyy + shift;
        xy = YYXX[sxxyy[1]][sxxyy[0]];
        
        translate([xy[0],xy[1],minus_z]) {
            color("Black") text( "-" ,size=4, halign="left");
        }
        
        translate([xy[0],xy[1],plus_z]) {
            color("Black") text( "+" ,size=4, halign="right");
        }
    }
}

T9 = [[3,2],[1,0],[0,0],[2,4],[1,4],[1,3],[2,3],[3,2] ];
T9P = [[0,0],[1,1],[2,2],[1,3],[1,4]];
tab(true, [[0,3],[1,2],[0,1],[0,2],[0,4]],[]);
tab(true, T9 ,T9P);
tab(true, T9 ,T9P, 2);
tab(true, T9 ,T9P, 4);
tab(true, T9 ,T9P, 6);
tab(true, T9 ,T9P, 8);
tab(true, [[10,0],[12,2],[11,3],[13,3],[12,1],[12,0],[10,0]],
          [[10,0],[11,1],[12,2],[12,3],[11,3]]);
tab(true, [[14, 2], [14, 1],[13, 0], [13, 1], [14, 3]],
          [[14, 2], [14, 1],[13, 0], [13, 1], [14, 3]]);


tab(false, [[0,0],[0,2],[0,4],[1,4],[1,2],[2,2],[0,0]],[[0,1],[0,2],[1,2],[0,3],[0,4]]);
tab(false, T9 ,T9P, 1);
tab(false, T9 ,T9P, 3);
tab(false, T9 ,T9P, 5);
tab(false, T9 ,T9P, 7);
tab(false, [[9,0],[11,2],[10,3],[10,4],[11,3],[12,3],[10,0],[9,0]],
           [[9,0],[10,1],[11,2],[10,3],[10,4]]);
tab(false, [[11,0],[13,3],[14,3],[14,2],[14,1],[13,0],[11,0]],
           [[11,0],[12,0],[12,1],[13,2],[13,3]]);

    
    


