use <2d.scad>

square_hole = 11.5;

crossbar_spacing = [ 49.5, 53, 57];

thickness = 3;
offset = 4 ;
lip_hight = 5;
lip_offset = square_hole/2 + thickness/2;
v_gap = 2.5;
tie_hole = [5, 2];
cb_hole = [square_hole, square_hole];

e=.05;

function addl(list, c = 0) = c < len(list) - 1 ? list[c] + addl(list, c + 1) : list[c];

cb_width = addl( crossbar_spacing );
cb_0 = cb_width/2;
cb_offsets = [ for(i = [0:len(crossbar_spacing)-1]) addl(crossbar_spacing, i)-cb_0, -cb_0 ];
echo(cb_offsets);
l = square_hole + 2 * offset + cb_width;
h = square_hole + 2 * offset ;
echo(l);

module bat_spacer(){
    module boxes(){
        cube([l,h,thickness], center=true);
        for(x=cb_offsets) translate([x+lip_offset,0,thickness/2+lip_hight/2-e]) cube([thickness,square_hole-1,lip_hight], center=true);
        for(x=cb_offsets) translate([x-lip_offset,0,thickness/2+lip_hight/2-e]) cube([thickness,square_hole-1,lip_hight], center=true);
    }
    module hole(d){
        cube([d[0],d[1],2*lip_hight+2*e+thickness], center=true);
    }
    module holes(){
        for(x=cb_offsets) translate([x,0,0]) hole(cb_hole);
        for(x=cb_offsets) translate([x+15,3,0]) hole(tie_hole);
        for(x=cb_offsets) translate([x+15,-3,0]) hole(tie_hole);
        for(x=cb_offsets) translate([x-15,3,0]) hole(tie_hole);
        for(x=cb_offsets) translate([x-15,-3,0]) hole(tie_hole);

    }

    difference(){
        boxes();
        holes();
    }
}


 for (i=[0:3])
    translate([0,i*21,0])
     bat_spacer();

