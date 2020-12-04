use <vector.scad>

function max_x(a, i = 0) = (len(a) == 0) ? 0 : (i < len(a) - 1) ? max(a[i][0], max_x(a, i+1)) : a[i][0];
function shift_x(a, dx, scaler=1) = [for ( p=a) [scaler*p[0]+dx,p[1]] ];

function scale_poly(a, s=[1,1]) = [for (p=a) [ s[0]*p[0], s[1]*p[1] ]];
function shift_poly(a, d=[0,0]) = [for (p=a) [ d + p ]];

function inverse_x(a) = shift_x(reverse(a),max_x(a),-1);
function mirror_x(a) = shift_x(reverse(a),0,-1);

function symmetry_x(a) = scale_poly(reverse(a),s=[-1,1]);
function symmetry_y(a) = scale_poly(reverse(a),s=[1,-1]);

function concat_with_undefs(prev,next) = 
    len(prev) == 0 ? next : 
        let (prev_last_p = prev[v_index(prev,-1)]) 
        is_undef(prev_last_p[1])  
            ? concat(slice(prev,0,-1),[[prev_last_p[0],next[0][1]]],next) 
            : is_undef(next[0][1]) 
                ? concat(prev, [[next[0][0],prev_last_p[1]]], slice(next,1)) 
                : concat(prev, next) ;

function join_poly(polys, r = [], i=0) = (i < len(polys)) ? 
    join_poly( polys, concat_with_undefs(r,shift_x(polys[i],max_x(r))) ,i+1) : r;

function line_segment(p1,p2) = [p1,[p2[0]-p1[0], p2[1] - p1[1]]];

function ls_slope(ls) = ls[1][1]/ls[1][0] ;

function ls_distance(ls) = sqrt(pow(ls[1][1],2)+pow(ls[1][0],2));

function ls_angle(ls) = 
    let (ta = asin(ls[1][1]/ls_distance(ls))) 
    sign(ls[1][0]) == -1 ? sign(ta) * 180 - ta : ta ;

function angle_diff_cw(a1, a2) = a1 < a2 ? angle_diff_cw(a1+360, a2) : a1 - a2 ;

function angle_diff_ccw(a1, a2) = angle_diff_cw(a2, a1);

function ls_midpoint(ls) = ls[0]+ls[1]/2;

function ls_endpoint(ls) = ls[0]+ls[1];

function line(slope,pt) = [slope, pt[1]-slope*pt[0]];

function l_y(l,x) = l[0]*x + l[1];

function l_segment(l,x1,x2) = line_segment([x1, l_y(l,x1)], [x2, l_y(l,x2)]);

function ls_line(ls) = let(slope=ls_slope(ls)) line(slope,ls[0]);

function ls_perpendicular(ls) = 
    let (l = ls_line(ls)) 
    let (mp = ls_midpoint(ls))
    line(-1/l[0], mp);

function intersect_lines(l1, l2) = 
    let (x = (l2[1]-l1[1])/(l1[0]-l2[0]))
    [x,l_y(l1,x)];

function interpolate_point(ls,fraction) =  [
    ls[0][0] + fraction*ls[1][0],
    ls[0][1] + fraction*ls[1][1]
];

function bezier_curve(p1 , p2,  p3) =
    [line_segment(p1,p2), line_segment(p2, p3)];

function curve_point(bc, fraction) =
    interpolate_point(
        line_segment(
            interpolate_point(bc[0],fraction), 
            interpolate_point(bc[1], fraction)), 
        fraction);

function bc_poly(bc, n_points=10) = [for ( f = [0:1/n_points:1]) curve_point(bc, f)] ;

function rake_poly(up_ramp, down_to_valley, n_of_valleys) = 
    join_poly(concat(
        [up_ramp],
        repeat(
            [
                down_to_valley, 
                inverse_x(down_to_valley) // up on other side of the valley
            ], 
            n_of_valleys),
        [inverse_x(up_ramp)] // down ramp
    ));


function arc_point(a,f) = 
    let(c = a[0])
    let(r = a[1])
    let(initial_angle = a[2])
    let(cw = a[3])
    let(range = a[4])
    let (angle = cw ? initial_angle - f * range : initial_angle + f * range)
    c+[r*cos(angle),r*sin(angle)];

function arc_poly(a, n_points=10) = [for ( f = [0:1/n_points:1]) arc_point(a, f)] ;

function arc( p1, p2, p3 ) =
    let(ls1 = line_segment(p1,p2))
    let(ls2 = line_segment(p2,p3))
    let(ls3 = line_segment(p1,p3))    
    let(lp1 = ls_perpendicular(ls1))
    let(lp2 = ls_perpendicular(ls2))
    let(lp3 = ls_perpendicular(ls3))
    let(c12 = intersect_lines(lp1,lp2))
    let(c23 = intersect_lines(lp2,lp3))
    let(c13 = intersect_lines(lp1,lp3))
    let(c = !is_nan(c23[0]) ? c23 : !is_nan(c13[0])? c13 : c12 )
    let(r1 = line_segment(c,p1))
    let(r2 = line_segment(c,p2))
    let(r3 = line_segment(c,p3))
    let(r = ls_distance(r1))
    let(a1 = ls_angle(r1))
    let(a2 = ls_angle(r2))
    let(a3 = ls_angle(r3))
    let(cw = angle_diff_cw(a1,a2) < angle_diff_cw(a1,a3))
    let(a_diff = cw ? angle_diff_cw(a1,a3) : angle_diff_ccw(a1,a3))
    [c,r,a1,cw,a_diff];


