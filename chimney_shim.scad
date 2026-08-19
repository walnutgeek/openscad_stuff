
t = 3; 
w = 3*t;
h = 4*t;

for( x = [0:2] ) {
    for( y = [0:2] ) {
        translate([(h+2)*x,(w+2)*y,0])
            linear_extrude(height=8)
            polygon(points=[
                [0,0],[0,w],[t,w],[t,t],[h,t/2],[h,0]]);
    }
}

