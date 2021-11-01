n_cells = 3;
d = 18.5;
gap = 1.4;
angle = 44 ;
lip = .5;
e = .01;

start = [d/2 + gap, d/2 + gap];
step_x = (d + gap)*sin(angle);
step_y = (d + gap)*cos(angle);
rect = [ start[0]*2 + (n_cells-1)*step_x, start[1]*2+step_y, 4 ];

echo(rect);

difference(){
    cube( rect );
    for( i = [0:n_cells-1] ) bat(start + [ step_x * i, step_y*(i%2)]);
}

module bat(xy){
    union(){
        translate( [xy[0], xy[1], lip]) 
            cylinder ( 5, d/2, d/2 );
        translate( [xy[0], xy[1], -e]) 
            cylinder ( 5, d/2-lip, d/2-lip );
    }
}