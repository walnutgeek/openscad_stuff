function is_nan(x) = x != x ;

// reverse vector
function reverse(v) = [for (i =[len(v)-1:-1:0]) v[i]];
// repeat vector n-times
function repeat(v, n) = [for (i=[0:n*len(v)-1])  v[ i%len(v) ] ];
// allow negative indexes for vector (counting from the back). -1 is last element in array
function v_index(v, n) = is_undef(n) ? len(v) : n < 0 ? len(v)+n : n ;
// cut slice of vertor. `start` included , `end` excluded.
function slice(v, start, end=undef) = [for (i=[start:v_index(v,end)-1]) v[i] ];

assert(reverse([1,2,3]) == [3,2,1]);
assert(repeat([1,2],3) ==  [1, 2, 1, 2, 1, 2]);
assert(v_index([1,2,3],-1)==2);
assert(v_index([1,2,3],0) == 0);
assert(v_index([1,2,3],undef)==3);
assert(slice([1,2,3],1,-1)==[2]);
assert(slice([1,2,3],1)==[2,3]);