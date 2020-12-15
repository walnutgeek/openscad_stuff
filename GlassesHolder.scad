use <2d.scad>
e=.001;
top = [74,8.3];
bottom=[69,-2];
holder = concat([[54,5],[68,0],[73,8]],arc_poly(arc([73,8],top,[75,7])),
[bottom],arc_poly(arc([53,3],[52.5,4],[54,5])));

m=[[-1,0],[0,1]];

module countersink(hole_d,hole_h, screw_d,screw_h){
    h = hole_h - screw_h ;
    union(){
        cylinder(d=hole_d,h=h+e,$fn=50);
        translate([0,0,h]) cylinder(d1=hole_d, d2=screw_d,h=screw_h,$fn=50);
    }
}

module backwall(ww)
    union(){
        // screw hole
        translate([ww,0,-1.99]) 
            countersink(2.5,5,6,2.3);
    }
difference(){
    union(){
        linear_extrude(height=20,,scale=[.98,.9])
        polygon(points=holder);

        linear_extrude(height=20,scale=[.98,.9])
        polygon(points=scale_poly(holder,s=[-1,1]));

        linear_extrude(height=3)
        polygon(points=concat(
            bc_poly(bezier_curve(top,[0,0],top*m)),
            bc_poly(bezier_curve(bottom*m,[0,-20],bottom))
        ));

        translate([1.5,0,0])
        rotate([0,-90,0])
        linear_extrude(height=3)
        polygon(points=concat(
            bc_poly(bezier_curve([0,3],[20,0],[43,0])),
            bc_poly(bezier_curve([43,0],[47,0],[50,2])),
            bc_poly(bezier_curve([50,2],[77,20],[83,24])),
            bc_poly(bezier_curve([84,23],[45,-15],[0,-15]))
        ));
    }
    backwall(40);
    backwall(-40);
}