e = .1;

module spacer(h1, h2, h3, base, h_hand){
    cube([base,base,h1], center=false);
    cube([base-h1,base,h2], center=false);
    cube([base-h1,base-h2,h3], center=false);
    translate([h3,0,0]) cube([base-h1-h3,base-h2,h3+h_hand], center=false);
}

for( x = [0:3] ) {
    for( y = [0:3] ) {
        translate([27*x,27*y,0])
            spacer(6, 9.5, 13, 25, 50);
    }
}