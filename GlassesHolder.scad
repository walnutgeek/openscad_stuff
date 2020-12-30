use <2d.scad>
e=.01;
th=3;

top = [76,9.3];
bottom=[60,-2];


module countersink(hole_d,hole_h, screw_d,screw_h){
    h = hole_h - screw_h ;
    union(){
        cylinder(d=hole_d,h=h+e,$fn=50);
        translate([0,0,h]) cylinder(d1=hole_d, d2=screw_d,h=screw_h,$fn=50);
    }
}


hp = [23,8];
bp = [0,-6];
hp1 = hp+[.5,-1];
function mid(a,b,ratio=.5) = a*ratio + b * (1-ratio);
hp2 = mid(hp1,bp,.8)+[0,-2];

hook_poly = concat(
        bc_poly(bezier_curve([0,5],[10,6],hp)),
        arc_poly(arc(hp,hp+[.09,.02],hp1)),
        bc_poly(bezier_curve(hp1,mid(hp1,hp2)+[-.5,.5],hp2)),
        bc_poly(bezier_curve(hp2,mid(hp2,bp)+[3,-4],bp))
    );

tbump =[1,0];
bump_poly = arc_poly(arc(tbump,mid(tbump,bp)+[7,0],bp));

module side_support(ww,poly){
    translate([ww+th/2,26,0]) 
    rotate([0,-90,0])
    linear_extrude(height=th)
    polygon(points=poly);
}

turn_up1 = top-[30,-3.7];
turn_up2 = top-[26,-12];
turn_down = top-[15,-12];
halfback = concat(
            bc_poly(bezier_curve([0,0],top-[45,5],turn_up1)),
            bc_poly(bezier_curve(turn_up1,top-[27,-5],turn_up2)),
            arc_poly(arc(turn_up2,top-[16,-15],turn_down)),
            bc_poly(bezier_curve(turn_down,top-[13,-5],bottom)),
            bc_poly(bezier_curve(bottom,bottom-[3,8],[0,-20]))
        );


module backwall(ww)
    union(){
        translate([ww,0,-2+e]) 
            countersink(2.5,5,6,2.3);
    }

// hook(0);
tbase=[0,3];
bbase=[0,-15];
tip=[78,16];
ttip=tip+[-2,1];

horn_poly = concat(
            bc_poly(bezier_curve(tbase,mid(tbase,ttip,.2)-[0,5],ttip)),
            arc_poly(arc(ttip,tip+[0,.7],tip)),
            bc_poly(bezier_curve(tip,mid(tip,bbase,.8)-[0,7],bbase))
        );
horn_support = arc_poly(arc(tbase,mid(tbase,bbase)+[9,0],bbase));

module centered_poly(h,poly){
    translate([h/2,0,0])
    rotate([0,-90,0])
    linear_extrude(height=h)
    polygon(points=poly);
}

difference(){
    union(){
        linear_extrude(height=th)
        polygon(points=concat(halfback, symmetry_x(halfback)
        ));

        translate([0, -3.5, 0]){
            centered_poly(th,horn_poly);
            centered_poly(th+2,horn_support);
        }
        side_support(55.5,bump_poly);
        side_support(-55.5,bump_poly);

        translate([0,-23, 0]) {
            side_support(55.5,hook_poly);
            side_support(-55.5,hook_poly);
        }

    }
    backwall(40);
    backwall(-40);
}


// translate([0,20,15]) color("blue") 
// rotate([0,90,0]) cylinder(h=400,r=.2,center=true);