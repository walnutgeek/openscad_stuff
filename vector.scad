// reverse vector
function reverse(v) = [for (i =[len(v)-1:-1:0]) v[i]];
// repeat vector n-times
function repeat(v, n) = [for (i=[0:n*len(v)-1])  v[ i%len(v) ] ];
// allow negative indexes for vector (counting from the back). -1 is last element in array
function v_index(v, n) = is_undef(n) ? len(v) : n < 0 ? len(v)+n : n ;
// cut slice of vertor. `start` included , `end` excluded.
function slice(v, start, end=undef) = [for (i=[start:v_index(v,end)-1]) v[i] ];

echo("reverse([1,2,3]", reverse([1,2,3]));
echo("repeat([1,2],3)",repeat([1,2],3));
echo("v_index([1,2,3],-1)",v_index([1,2,3],-1));
echo("v_index([1,2,3],0)",v_index([1,2,3],0));
echo("v_index([1,2,3],undef)",v_index([1,2,3],undef));
echo("slice([1,2,3],1,-1)",slice([1,2,3],1,-1));
echo("slice([1,2,3],1)",slice([1,2,3],1));