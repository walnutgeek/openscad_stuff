use <vector.scad>

function max_x(a, i = 0) = (len(a) == 0) ? 0 : (i < len(a) - 1) ? max(a[i][0], max_x(a, i+1)) : a[i][0];
function shift_x(a, dx, scaler=1) = [for ( p=a) [scaler*p[0]+dx,p[1]] ];
function inverse_x(a) = shift_x(reverse(a),max_x(a),-1);

function concat_with_undefs(prev,next) = 
    len(prev) == 0 
        ? next 
        : is_undef(prev[v_index(prev,-1)][1])  
            ? concat(slice(prev,0,-1),[[prev[v_index(prev,-1)][0],next[0][1]]],next) 
            : is_undef(next[0][1]) 
                ? concat(prev, [[next[0][0],prev[v_index(prev,-1)][1]]], slice(next,1)) 
                : concat(prev, next) ;

function join_poly(polys, r = [], i=0) = (i < len(polys)) ? 
    join_poly( polys, concat_with_undefs(r,shift_x(polys[i],max_x(r))) ,i+1) : r;

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

module flat_hanger(n, ramp, down_to_valley){
    polygon(points=rake_poly(up_ramp, down_to_valley, n_of_valleys));
}
