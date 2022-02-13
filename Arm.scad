$fn = 32;

module Arm(list = [[[1,2],[1,2,3],[1,[2,1],undef]],
                  1, 
                  [1,[1,1,.5,[-30,30],[2,30,[1,-30]]]]]) {
    echo( Arm = list);
    diam =  list[0][0];
    heig =  list[0][1];
    next =  list[0][2];
    fork = [list[1], list[2]];
    
    if (is_num(fork[0]))
        rotate([0, 90])
            cylinder(h = fork[0], d = diam[0], center = true);
    
    cylinder(h = heig[0], d = diam[0]);     
    translate([0, 0, heig[0]]) {
        cylinder(h = heig[1], d1 = diam[0], d2 = diam[1]);
        translate([0, 0, heig[1]])
        
        if (is_list(next)) {
            diam = [diam[1],next[0]];
            heig = [heig[2],next[1][0],next[1][1]];
            next =  next[2];
            Arm([[diam,heig,next],undef,fork[1]])
                children();
        }
        else {
            cylinder(h = heig[2], d = diam[1]);
            translate([0, 0, heig[2]])      
                if (is_undef(fork[1])) 
                    children();
                else {
                    if (is_list(fork[1])) {
                        heig = fork[1][0];
                        rotate([0, -90])
                            cylinder(h = heig, d = diam[1], center = true);
                        Fork(fork[1])
                            children();
                    }
                    else {
                        rotate([0, -90])
                            cylinder(h = diam[1], d = diam[1], center = true);
                        children();
                    };
                };
        };
    };
    include<Fork.scad>;
};

rotate([$t * 360]) Arm() rotate([$t * 360]) Arm();