use <2d.scad>
e=.01;
top = [74,8.3];
inner_conner = [71,0];
bottom=[inner_conner[0]+1,-2];

holder = concat([[54,5],inner_conner],arc_poly(arc([73,8],top,[75,7])),
[bottom],arc_poly(arc([53,3],[52.5,4],[54,5])));

m=[[-1,0],[0,1]];


module countersink(hole_d,hole_h, screw_d,screw_h){
    h = hole_h - screw_h ;
    union(){
        cylinder(d=hole_d,h=h+e,$fn=50);
        translate([0,0,h]) cylinder(d1=hole_d, d2=screw_d,h=screw_h,$fn=50);
    }
}


hp = [15,15];
hp2 = [10,6];

module hook(ww){
    translate([ww+1.5,25,0]) 
    rotate([0,-90,0])
    linear_extrude(height=3)
    polygon(points=concat(
        bc_poly(bezier_curve([0,10],[10,16],hp)),
        arc_poly(arc(hp,hp+[.09,.02],hp+[.5,-1])),
        bc_poly(bezier_curve(hp+[.5,-1],[10,10],hp2)),
        bc_poly(bezier_curve(hp2,[10,-7],[0,-10]))
    ));
}

turn_up1 = top-[30,-3.7];
turn_up2 = top-[26,-12];
turn_down = top-[15,-12];
halfback = concat(
            bc_poly(bezier_curve([0,0],top-[45,5],turn_up1)),
            bc_poly(bezier_curve(turn_up1,top-[27,-5],turn_up2)),
            arc_poly(arc(turn_up2,top-[16,-15],turn_down)),
            bc_poly(bezier_curve(turn_down,top-[15,-5],top)),
            bc_poly(bezier_curve(bottom,bottom-[10,0],[0,-20]))
        );


module backwall(ww)
    union(){
        translate([ww,0,-2+e]) 
            countersink(2.5,5,6,2.3);
    }

// hook(0);
tip=[56,11];

horn_poly = concat(
            bc_poly(bezier_curve([0,3],[35,-5],[54,12])),
            arc_poly(arc(tip+[-2,1],tip+[0,1],tip)),
            bc_poly(bezier_curve(tip,[45,-15],[0,-15]))
        );
horn_support = arc_poly(arc([0,3],[9,-6],[0,-15]));

module centered_poly(h,poly){
    translate([h/2,0,0])
    rotate([0,-90,0])
    linear_extrude(height=h)
    polygon(points=poly);
}

difference(){
    union(){
        linear_extrude(height=20,,scale=[.98,.9])
        polygon(points=holder);

        linear_extrude(height=20,scale=[.98,.9])
        polygon(points=scale_poly(holder,s=[-1,1]));

        linear_extrude(height=3)
        polygon(points=concat(halfback, symmetry_x(halfback)
        ));

        centered_poly(3,horn_poly);
        centered_poly(5,horn_support);

        hook(53.5);
        hook(-53.5);
    }
    backwall(40);
    backwall(-40);
}


// translate([0,20,15]) color("blue") 
// rotate([0,90,0]) cylinder(h=400,r=.2,center=true);