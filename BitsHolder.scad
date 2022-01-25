// bit_sizes = [ 5.59, 5.16, 4.76, 4.35, 3.93, 3.58, 3.18 ]; add_space = [];
// bit_sizes = [ 7, 7, 7, 4.75 ]; add_space = [4,8,8,8,4];
hex1o4 = 7.1;
bit_sizes = [ hex1o4, hex1o4, hex1o4, hex1o4, hex1o4 ]; add_space = [3,5,5,5,5,3];

space = 1.8;
e = .2; // enlarge holes by amount
h = 11.5;
slot = .8;

function get_space(i) = space + ( i < len(add_space) ? add_space[i] : 0 );

use <vector.scad>

length = asum([ for (i = [0: len(bit_sizes)]) get_space(i) ]) + asum(bit_sizes);
width = amax(bit_sizes) + 2 * space;

steps = [ for (i = [0:len(bit_sizes)-1]) get_space(i) + bit_sizes[i]/2 + 
            (i > 0 ? bit_sizes[i-1]/2 : 0) ];

p = [ for (i = [0:len(bit_sizes)-1]) asum(slice(steps,0,i+1)) ];
d = [ for (i = [0:len(bit_sizes)-1]) bit_sizes[i]+e ];
echo(p,d);

difference() {
    translate([0,-width/2,0]) cube([length, width+1, h]);
    union(){
        for( i = [0:len(p)-1]){
            translate([p[i], 0, -e]) cylinder( h = h+2*e, d1=d[i], d2=d[i] , $fn=100 );
            translate([p[i]-slot/2, -width, -e]) cube ([slot, width, h+2*e]);
        }
    }
}

