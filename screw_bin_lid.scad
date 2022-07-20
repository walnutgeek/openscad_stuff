c=[103,73,2];
t = 3;
t2 = 2 * t;
e = .1;
difference(){
 cube(c);
 translate([t,t,-e])
 cube(c + [-t2,-t2,e*2]);
}
