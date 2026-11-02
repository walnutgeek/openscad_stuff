// USB dongle holder: L bracket with a row of blind slots in the base,
// alternating USB-A and USB-C, and a handle in the middle of the back wall.
//
// X - along the bracket, Y - front to back, Z - up

/* [Bracket] */
len      = 140;  // bracket length
base_w   = 15;   // base depth (front to back), wall included
base_h   = 7;    // base thickness = slot depth + floor under slots
wall     = 2;    // back wall thickness
wall_h   = 15;   // back wall height from the bottom
corner_r = 1;    // rounding of the outer vertical corners

/* [Handle] */
handle_h    = 50; // handle height from the bottom
handle_w    = 30; // handle width
finger_d    = 18; // finger hole diameter, 0 for none

/* [Slots] */
usba        = [12.2, 4.6]; // USB-A plug [width, thickness]
usbc        = [8.3, 2.6];  // USB-C plug [width, thickness]
clear       = 0.2;  // added to each slot dimension
slot_depth  = 5;
min_gap     = 2;    // minimal spacing between slots
end_margin  = 3;    // minimal material at each end
slot_count  = 0;    // 0 = as many as fit
pattern     = "AC"; // slot types, repeated: "AC" alternates, "A" only USB-A, "C" only USB-C
spread      = true; // true = spread slots over the length, false = exactly min_gap, centered
chamfer     = 0.5;  // lead-in chamfer at the slot opening

$fn = 64;
e = 0.01;

slot_y   = (base_w - wall) / 2;  // slots centered on the open part of the base
avail    = len - 2 * end_margin;

function slot_type(i) = pattern[i % len(pattern)];
function slot_dim(i) = (slot_type(i) == "A" ? usba : usbc) + [clear, clear];
function sum_w(n) = n <= 0 ? 0 : slot_dim(n - 1)[0] + sum_w(n - 1);
function fits(n) = sum_w(n) + (n - 1) * min_gap <= avail;
function max_count(n = 1) = fits(n + 1) ? max_count(n + 1) : n;

n   = slot_count > 0 ? slot_count : max_count();
gap = n > 1 && spread ? (avail - sum_w(n)) / (n - 1) : min_gap;
assert(sum_w(n) + (n - 1) * gap <= avail + e, "slots do not fit");
x0  = (len - sum_w(n) - (n - 1) * gap) / 2; // start of the row

function count(t, i = 0) = i >= n ? 0 : (slot_type(i) == t ? 1 : 0) + count(t, i + 1);
echo(str("Slots: ", n, " (", count("A"), " USB-A, ", count("C"), " USB-C), gap ", gap, " mm"));

module rounded_rect(l, w, r) {
    offset(r = r) offset(delta = -r) square([l, w]);
}

module slot(d) {
    l = d[0]; t = d[1];
    translate([-l / 2, -t / 2, base_h - slot_depth])
        cube([l, t, slot_depth + e]);
    // lead-in chamfer
    translate([0, 0, base_h - chamfer])
        hull() {
            linear_extrude(height = e) square([l, t], center = true);
            translate([0, 0, chamfer]) linear_extrude(height = e)
                square([l + 2 * chamfer, t + 2 * chamfer], center = true);
        }
}

module slots() {
    for (i = [0 : n - 1])
        translate([x0 + sum_w(i) + i * gap + slot_dim(i)[0] / 2, slot_y, 0])
            slot(slot_dim(i));
}

// handle profile in XZ, rounded top with a finger hole
module handle_profile() {
    r = handle_w / 2;
    difference() {
        hull() {
            translate([-r, 0]) square([handle_w, e]);
            translate([0, handle_h - r]) circle(r = r);
        }
        if (finger_d > 0)
            translate([0, handle_h - r]) circle(d = finger_d);
    }
}

module bracket() {
    difference() {
        union() {
            linear_extrude(height = base_h) rounded_rect(len, base_w, corner_r);
            // back wall
            translate([0, base_w - wall, 0])
                linear_extrude(height = wall_h) rounded_rect(len, wall, min(corner_r, wall / 2 - e));
            // handle
            translate([len / 2, base_w, 0]) rotate([90, 0, 0])
                linear_extrude(height = wall) handle_profile();
        }
        slots();
    }
}

bracket();
