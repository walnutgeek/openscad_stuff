// Stackable DIMM memory module box
// 16 modules in 4 sections of 4, concave side walls and dividers
// so modules of any height can be grabbed from the side.
//
// X - along module length, Y - across modules, Z - up

/* [Modules] */
mod_len    = 140;  // DIMM length
len_clear  = 2;    // total extra length inside
mod_thk    = 8;    // assumed thickness per module (with heatsink)
mods_per_section = 4;
sections   = 4;

/* [Box] */
wall       = 3;    // outer wall thickness
divider    = 3;    // divider thickness
floor_t    = 2;    // floor thickness
edge_h     = 55;   // wall height above the floor at the ends
dip_h      = 18;   // lowest point of the concave cut above the floor
end_margin = 12;   // full-height wall left at each end (inside)
top_round  = 6;    // rounding where the concave cut meets the rim
corner_r   = 3;    // outer vertical corner radius

/* [Stacking] */
stack_h     = 2;   // height of the bottom locating foot
stack_clear = 0.4; // clearance per side between foot and lower box walls
div_gap     = 0.5; // gap between divider top and foot of the upper box

$fn = 64;

section_w = mods_per_section * mod_thk;               // 32
in_L  = mod_len + len_clear;                          // 142
in_W  = sections * section_w + (sections - 1) * divider; // 137
out_L = in_L + 2 * wall;                              // 148
out_W = in_W + 2 * wall;                              // 143
rim_z = stack_h + floor_t + edge_h;                   // top of the walls
floor_z = stack_h + floor_t;                          // top of the floor
div_h = edge_h - stack_h - div_gap;                   // dividers stay below the upper box foot

echo(str("Outer: ", out_L, " x ", out_W, " x ", rim_z, " mm"));
echo(str("Clearance above a 52mm module when stacked: ", edge_h - stack_h - 52, " mm"));

module rounded_rect(l, w, r) {
    offset(r = r) offset(delta = -r) square([l, w]);
}

// Concave cut profile in XZ plane, cuts side walls and dividers together
module concave_profile() {
    a = in_L / 2 - end_margin;   // half span of the cut
    b = rim_z - (floor_z + dip_h); // depth of the cut
    offset(r = -top_round) offset(r = top_round)
    union() {
        translate([out_L / 2, rim_z]) scale([a, b]) circle(r = 1, $fn = 180);
        translate([out_L / 2 - a - 2 * top_round, rim_z]) square([2 * a + 4 * top_round, 10]);
    }
}

module concave_cut() {
    translate([0, out_W + 1, 0])
        rotate([90, 0, 0])
            linear_extrude(height = out_W + 2) concave_profile();
}

module foot() {
    fl = in_L - 2 * stack_clear;
    fw = in_W - 2 * stack_clear;
    ch = 1; // lead-in chamfer
    translate([wall + stack_clear, wall + stack_clear, 0])
        hull() {
            translate([ch, ch, 0]) linear_extrude(height = 0.01) rounded_rect(fl - 2 * ch, fw - 2 * ch, 1);
            translate([0, 0, ch]) linear_extrude(height = stack_h - ch) rounded_rect(fl, fw, 1);
        }
}

module shell() {
    translate([0, 0, stack_h])
        difference() {
            linear_extrude(height = floor_t + edge_h) rounded_rect(out_L, out_W, corner_r);
            translate([wall, wall, floor_t])
                cube([in_L, in_W, edge_h + 1]);
        }
}

module dividers() {
    for (k = [1 : sections - 1])
        translate([wall, wall + k * section_w + (k - 1) * divider, floor_z - 0.01])
            cube([in_L, divider, div_h + 0.01]);
}

module dimm_box() {
    difference() {
        union() {
            shell();
            dividers();
            foot();
        }
        concave_cut();
    }
}

dimm_box();
