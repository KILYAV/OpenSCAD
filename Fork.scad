$fn = 32;

module Fork (list = [1,[1,1,.5,[30,30],[2,30,[1,-30]]]]) {
    echo(Fork = list);
    gap       = list[0];
    thickness = list[1][2];
    slab      = list[1];
        
    rotate([0, -90]) {
        translate([0, 0,  (thickness + gap) / 2])
            Slab(slab);
        translate([0, 0, -(thickness + gap) / 2])
            Slab(slab)
                translate([0, 0,  (thickness + gap) / 2])
                    rotate([0, 90])
                        children();
    };
    
    module Slab (list = [3,1,.5,[30,30],[2,30,undef]]) {
        echo(Slab = list);
        length    = list[0];
        diameter  = list[1];
        thickness = list[2];
        angle     = is_list(list[3]) ? list[3]:
                     is_num(list[3]) ? [0, list[3]]: [0,0];
        next      = list[4];
        
        rotate([0, 0, angle[0]]) {
            cylinder(h = thickness, d = diameter, center = true);
            translate([length / 2, 0, 0])
                cube([length, diameter, thickness], center = true);
            translate([length, 0, 0]) {
                if (is_list(next)) {
                    rotate([0, 0, angle[1]])
                        Slab([next[0], diameter, thickness, next[1], next[2]])
                            children();
                }
                else {
                    cylinder(h = thickness, d = diameter, center = true);
                    children();
                };
            };
        };
    };
};
    