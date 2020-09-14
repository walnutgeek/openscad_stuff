use <poly.scad>

profile= [[0, 13], [11, 13], [11, 12], [4, 5], [4, 0], [14, 0]];
ease=[[0,-8],[5,undef]];

linear_extrude(height=10) flat_hanger(2, ease, profile);