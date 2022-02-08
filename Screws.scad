e=.01;
$fn=100;

function s1_25() = // Drywall 1 1/4" screw
    let(total_len = 32.3)
    let(thread = 21.5)
    let(shank = 8)
    let(d_shank = 3.5)
    let(d_hat = 8.6)
    [total_len, thread, shank, total_len-thread-shank, d_shank-.5, d_shank, d_hat];

function s2() = // Drywall 2" screw
    let(total_len = 51.4)
    let(thread = 33.5)
    let(shank = 13.3)
    let(d_shank = 3.5)
    let(d_hat = 8.6)
    [total_len, thread, shank, total_len-thread-shank, d_shank-.5, d_shank, d_hat];  

function a10x0x2x2x6mm() = // artika lamp 10mm screw
    let(total_len = 10)
    let(shank = 0)
    let(thread = total_len - shank - 2)
    let(d_shank = 3)
    let(d_hat = 6)
    [total_len, thread, shank, total_len-thread-shank, d_shank-.5, d_shank, d_hat];  

module screw(a, p=0.){
    total_len=a[0]; thread=a[1]; shank=a[2]; hat=a[3]; d_thread=a[4]; d_shank=a[5]; d_hat=a[6];
    union(){
        if( p > 0.) {
            translate([0,0,-p+e])
            cylinder(p,d1=d_hat,d2=d_hat);
        }
        cylinder(hat,d1=d_hat,d2=d_shank);
        translate([0,0,hat-e])
        if( p > 0.) {
            cylinder(shank+thread+p, d1=d_shank, d2=d_shank);
        }else{
            union(){
                cylinder(shank, d1=d_shank, d2=d_shank);
                translate([0,0,shank-e])
                cylinder(thread, d1=d_thread, d2=d_thread);
            }
        }
    }
}

//screw(s1_25());
//translate([10,0,0]) screw(s1_25(),5);
//translate([20,0,0]) screw(s2());
//translate([30,0,0]) screw(s2(),5);