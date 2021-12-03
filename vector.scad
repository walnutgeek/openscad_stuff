function is_nan(x) = x != x ;

// reverse vector
function reverse(v) = [for (i =[len(v)-1:-1:0]) v[i]];
// repeat vector n-times
function repeat(v, n) = [for (i=[0:n*len(v)-1])  v[ i%len(v) ] ];
// allow negative indexes for vector (counting from the back). -1 is last element in array
function v_index(v, n) = is_undef(n) ? len(v) : n < 0 ? len(v)+n : n ;
// cut slice of vertor. `start` included , `end` excluded.
function slice(v, start, end=undef) = start >= v_index(v,end) ? [] : [for (i=[start:v_index(v,end)-1]) v[i] ];

function v_add(v, n) = [for (i=[0:len(v)-1]) v[i]+n ];

function asum(a, i = 0) = i < len(a) ? a[i] + asum(a, i+1) : 0;

function amax(a, i = 0) = i < len(a) ? max(a[i], amax(a, i+1)) : 0;

assert(asum([5,3,1])==9);
assert(asum(slice([5,3,1],0,1))==5);
assert(asum(slice([5,3,1],0,2))==8);
assert(asum(slice([5,3,1],0,0))==0);

assert(amax([5,3,9,1])==9);

assert(reverse([1,2,3]) == [3,2,1]);
assert(repeat([1,2],3) ==  [1, 2, 1, 2, 1, 2]);
assert(v_index([1,2,3],-1)==2);
assert(v_index([1,2,3],0) == 0);
assert(v_index([1,2,3],undef)==3);
assert(slice([1,2,3],1,-1)==[2]);
assert(slice([1,2,3],1)==[2,3]);
assert(v_add([1,2,3],1)==[2,3,4]);