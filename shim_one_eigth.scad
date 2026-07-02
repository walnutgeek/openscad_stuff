w = 12;
h =18;
c = 5;
t = 3; 

for( x = [0:3] ) {
    for( y = [0:3] ) {
        translate([(h+2)*x,(w+2)*y,0])
            linear_extrude(height=30)
            polygon(points=[
                [0,0],[0,w],[c,w],[c,(w+t)/2],[h,(w+t)/2],[h,(w-t)/2],[c,(w-t)/2],[c,0]]);
    }
}

