w_mount = 17;
w_psu = 31;
gap = 4;
h = 15;
extrude = 10;
x_mount = w_mount/2;
x_bottom = x_mount+gap;
x_psu = w_psu/2;
x_top = x_psu+gap;
y_gap = gap/2;
y_ext = y_gap + h;
e=1;

linear_extrude(extrude)
polygon([
    [-x_top,y_ext],[-x_psu,y_ext],[-x_psu, y_gap+e],[-x_psu+e, y_gap],[x_psu-e, y_gap],[x_psu, y_gap+e],[x_psu,y_ext],[x_top,y_ext],
    [x_top,y_gap],[x_bottom,-y_gap],
    [x_bottom,-y_ext],[x_mount,-y_ext],[x_mount,-y_gap],[-x_mount,-y_gap],[-x_mount,-y_ext],[-x_bottom,-y_ext],
    [-x_bottom,-y_gap],[-x_top,y_gap]
]);