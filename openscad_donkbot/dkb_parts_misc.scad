/*
 * Module: dkb_parts_misc.scad
 * this file has generators for components used in DonKbot_mm projects,
 * specifically it generates standalone parts that are affixed to 
 * DonKbot robots (such as casters, LED shields for the linesensor board,
 * thumbnuts, "robot test stand" fixtures, etc)
 *
 * Project:   DonKbot_mm
 * Author(s): Don Korte
 * github:    https://github.com/dnkorte/donkbot
 *   
 * Note that this and all functional modules
 * within the DonKbot family also reference 3 true "core" modules that on
 * my computers actually live in a different folder because they provide
 * functionality for several additional projects.  However for most users, 
 * they may be stored in the same folder as the DonKbot files.
 *  The 3 "core" modules are:
 *      core_robo_functions.scad 
 *      core_config_dimensions.scad
 *      core_parts_wheels.scad
 * they can be found at https://github.com/dnkorte/lib_robo_core
 * 
 * if they are stored in a remote location, you may use a system ENVIRONMENT
 * VARIABLE called OPENSCADPATH to allow OpenSCAD to find them at that location.
 *
 * to implement the OPENSCADPATH library functionality, setup the environment var as follows:
 *      on linux, store a file called /etc/profile.d/openscadpath.sh with contents:  
 *          export OPENSCADPATH="/home/the_rest_of_the_path/" 
 *          (note that ~/.bashrc fails because its not run from terminal session)
 *      on Windows, by Control Panel / System / Advanced System Settings / Environment Variables / User Variable 
 * see https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries   for details
 * *************************************************************************
 *   
 * MIT License
 * 
 * Copyright (c) 2024 Don Korte
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 * *************************************************************************
 *  
 * Reference:
 *  https://github.com/dnkorte/donkbot
 *  https://github.com/dnkorte/lib_robo_core
 *  https://photos.app.goo.gl/n3T1WMVK3Vmwz7cS7  photo album random pics donkbot parts etc
 *  https://photos.app.goo.gl/D5PgzwZijvFSpFg68  photo album maze fabrication
 *  https://donstechstuff.com/
 *  https://openscad.org/
 *  https://donstechstuff.com
 *
 * Version History:
 *  20241204    - Initial Release
 */

include <dkb_core.scad>;

//part_wheel_dshaft( 25, 33, 6 );
//part_wheel_dshaft( 28, 36, 6 );
//part_wheel_dshaft( 31, 39, 6 );
//part_wheel_dshaft( 37, 45, 6 );
//part_wheel_tt( 28, 36, 6, "M25" );
//part_wheel_tt( 31, 39, 6, "M25" );
//part_wheel_tt( 37, 45, 6, "M25" );
//part_wheel_roundshaft( 28, 36, 6, 4 );	// nema-8 stepper
//part_wheel_roundshaft( 31, 39, 6, 2.8 );		// sparkfun stepper
//part_wheel_roundshaft( 34, 42, 6, 2.8 );		// sparkfun stepper

//part_linesensor_spacer(5);
//part_feather_tft_button_cover();
//part_feather_oled_button_cover();
//part_clicker_post();
//part_ls_shield();
//part_marker_led_shield();
//part_flyingplate_bicolor( 6 );
//part_flyingplate_bicolor_feather( 6 );
//part_flyingplate_bicolor_sparkfun( 6);


//part_mount_bracket_nema8();
//part_thumbnut(d=17, thick=3, hub_thickness=4, bolt_dia=3.5);
//part_caster_pin();   	// for standard plate
//part_caster_pin(5);		// for plate with 2mm riser
part_caster_pinned(10);
//part_robot_test_stand(15);
//fixture_pwr_dist_solder();

module part_thumbnut(d=20, thick=3, hub_thickness=5, bolt_dia=3.5) {
    difference() {
        union() {
            cylinder( d=(0.85*d), h=thick);
            cylinder( d=9, h=thick+hub_thickness);
            rotate([ 0, 0, 0 ]) roundedbox( (d/8), d, (d/16), thick);       
            rotate([ 0, 0, 30 ]) roundedbox( (d/8), d, (d/16), thick);      
            rotate([ 0, 0, 60 ]) roundedbox( (d/8), d, (d/16), thick);      
            rotate([ 0, 0, 90 ]) roundedbox( (d/8), d, (d/16), thick);      
            rotate([ 0, 0, 120 ]) roundedbox( (d/8), d, (d/16), thick);     
            rotate([ 0, 0, 150 ]) roundedbox( (d/8), d, (d/16), thick); 
        }
        translate([ 0, 0, -0.1 ]) cylinder( d=bolt_dia, h=thick+hub_thickness+0.2);
        translate([ 0, 0, thick+hub_thickness-3 ]) make_m3_hex_nut(h=3.1);
    }
}

/*
 * this should be printed on its side
 */
module part_mount_bracket_nema8() {	
	// these should match values from plate
	motormount_hole_spacing = 30;
	motormount_lift = 10;	// for the pillars that attach to motor mount brackets
	pad_size = 8;
	motor_dim = 20;

	difference() {
		union() {
			translate([ 0, -(motormount_hole_spacing + pad_size)/2, 0 ]) cube([ pad_size+4, motormount_hole_spacing + pad_size, 2 ] );	// the "feet"
			// the body "surround" of the bracket
			translate([ 0, -((motormount_hole_spacing - 6)/2), 0 ]) 
				cube([ pad_size + 4, motormount_hole_spacing - 6, motor_dim + 2 - motormount_lift ]);
		}
		// remove "inside" of bracket (for the the motor; note this starts 1mm inside bracket to provide lip)
		translate([ 1, -(motor_dim + 0.2)/2, -0.1 ]) cube([ pad_size + 6, motor_dim + 0.2, motor_dim - motormount_lift - 0.2 ]);
		// remove a window for the motor to peak out of
		translate([ -0.1, -(motor_dim + 0.2 - 4)/2, -0.1 ]) cube([ pad_size + 6, motor_dim + 0.2 - 4, motor_dim - motormount_lift - 0.2 - 2 ]);

		// mounting screws
		translate([ 7, +motormount_hole_spacing/2, -0.1 ]) cylinder( d=M3_throughhole_dia, h=2.2);
		translate([ 7, -motormount_hole_spacing/2, -0.1 ]) cylinder( d=M3_throughhole_dia, h=2.2);
	}
}


/*
 * this is only practical for thicknesses of 4 or more -- otherwise there's insufficient thickness for bolt
 */
module part_caster_pinned( radius = 6 ) {

	difference() {
		sphere( r=radius, $fn=100);
		translate([ -25, -25, -25 ]) cube([ 50, 50, 25 ]);
		translate([ 0, -0, -0.1 ]) cylinder( d=3.5, h=(radius-2));
	}

}

module part_caster_pin( pin_depth=3) {
	cylinder (d=7, h=2);
	translate([ 0, 0, plate_thick ]) cylinder ( d1=2.9, d2=2.9, h=plate_thick+pin_depth);	// note 2.5 top is ok too
}


module part_robot_test_stand( pillar_height = 15, want_finger_grips = true ) {
	difference() {
		translate([ -(plate_x+12)/2, -(plate_y+12)/2, 0 ]) cube([ plate_x+12, plate_y+12, 3 ]);
		translate([ -(plate_x-9)/2, -(plate_y-9)/2, -0.1 ]) cube([ plate_x-9, plate_y-9, 3.2 ]);
	}

	difference() {
		union() {
			// back posts (at corners)
			translate([ +plate_x/2, -plate_y/2, 0 ]) cylinder( d=16, h=pillar_height+5);
			translate([ -plate_x/2, -plate_y/2, 0 ]) cylinder( d=16, h=pillar_height+5);

			// front posts
			translate([ +(plate_x/2)-20, (plate_y/2), 0 ]) cylinder( d=16, h=pillar_height+5);
			translate([ -(plate_x/2)+20, (plate_y/2), 0 ]) cylinder( d=16, h=pillar_height+5);

			// side posts (forward)
			translate([ +(plate_x/2), +(plate_y/2)-20, 0 ]) cylinder( d=16, h=pillar_height+5);
			translate([ -(plate_x/2), +(plate_y/2)-20, 0 ]) cylinder( d=16, h=pillar_height+5);

			// logo
	        //translate([(plate_x/2)-4, 0, 0]) rotate([ 0, 0, 90 ]) linear_extrude(2) text("DonKbot", 
	        //    size=14,  halign="center", font = "Liberation Sans:style=Bold");

			// logo
	        translate([ 0, -(plate_y/2)+4,  0 ]) linear_extrude(2) text("DonKbot", 
	            size=12,  halign="center", font = "Liberation Sans:style=Bold");

	        if (want_finger_grips) {
		        translate([ (plate_x/2)+7, -10, 0 ]) roundedbox( 2, plate_x, 1, pillar_height);
		        translate([ -(plate_x/2)-7, -10, 0 ]) roundedbox( 2, plate_x, 1, pillar_height);

		        translate([ (plate_x/2)+6, -22, pillar_height+6 ]) rotate([0, 90, 0 ]) roundedbox( 17, 45, 4, 2);
		        translate([ -(plate_x/2)-8, -22, pillar_height+6 ]) rotate([0, 90, 0 ]) roundedbox( 17, 45, 4, 2);
		    }

		}

		// remove a plate-shaped section from the top of the pillars
		translate([ -(plate_x+1)/2, -(plate_y+1)/2, pillar_height ]) cube([ plate_x+1, plate_y+1, 8 ]);
	}
}


module part_feather_tft_button_cover() {
	cap_thick = 6;
	cover_x = 12;
	bolt_offset_x = 9;
	button_offset_x = 3;
	button_offset_y = 7;
	ctr_y = (board_feather_width/2);
	shelf_width = 6;
	shelf_thick = 3;
	header_window_y = 4;

	difference() {
		cube([ cover_x, board_feather_width, cap_thick ]);
		translate([ bolt_offset_x, ctr_y + (board_feather_screw_y/2), -0.1 ]) 
			cylinder( d=M3_throughhole_dia, h=cap_thick+0.2);
		translate([ bolt_offset_x, ctr_y - (board_feather_screw_y/2), -0.1 ]) 
			cylinder( d=M3_throughhole_dia, h=cap_thick+0.2);

		// shelf to clear button bodies	
		translate([ 0, 0, -0.1 ]) cube([ shelf_width, board_feather_width - 2, shelf_thick+0.1]);

		// clearance for header pins
		translate([ 0, 0, -0.1 ]) cube([ 6.0, header_window_y, cap_thick+0.2]);

		// insets to clear bottom of clicker posts
		translate([ button_offset_x, ctr_y + 0, -0.1 ]) cylinder( d=3.5, h=cap_thick + 2);
		translate([ button_offset_x, ctr_y + button_offset_y, -0.1 ]) cylinder( d=3.5, h=cap_thick + 2);

		// buttons 
		translate([ button_offset_x, ctr_y + 0, -0.1 ]) cylinder( d=6, h=shelf_thick+2 );
		translate([ button_offset_x, ctr_y + button_offset_y, -0.1 ]) cylinder( d=6, h=shelf_thick+2 );
	}
}

module part_feather_oled_button_cover() {
	cap_thick = 6;
	cover_x = 10;
	bolt_offset_x = 7;
	button_offset_x = 4.5;
	button_offset_y = 4.5;
	ctr_y = (board_feather_width/2);
	shelf_high_width = 4.5;
	shelf_high_thick = 3;
	shelf_body_width = 7;
	shelf_body_thick = 2;
	header_window_y = 6;
	header_window_x = 4.5;

	difference() {
		cube([ cover_x, board_feather_width, cap_thick ]);
		translate([ bolt_offset_x, ctr_y + (board_feather_screw_y/2), -0.1 ]) 
			cylinder( d=M25_throughhole_dia, h=cap_thick+0.2);
		translate([ bolt_offset_x, ctr_y - (board_feather_screw_y/2), -0.1 ]) 
			cylinder( d=M25_throughhole_dia, h=cap_thick+0.2);

		// shelf to clear button tops	
		translate([ 1.0, 0, -0.1 ]) cube([ shelf_high_width, board_feather_width, shelf_high_thick+0.1]);

		// shelf to clear button bodies	
		translate([ 1.0, 0, -0.1 ]) cube([ shelf_body_width, board_feather_width, shelf_body_thick+0.1]);

		// insets to clear bottom of clicker posts
		translate([ button_offset_x, ctr_y - button_offset_y, -0.1 ]) cylinder( d=3.5, h=cap_thick + 2);
		translate([ button_offset_x, ctr_y + button_offset_y, -0.1 ]) cylinder( d=3.5, h=cap_thick + 2);

		// buttons 
		translate([ button_offset_x, ctr_y - button_offset_y, -0.1 ]) cylinder( d=6, h=shelf_high_thick+2 );
		translate([ button_offset_x, ctr_y + button_offset_y, -0.1 ]) cylinder( d=6, h=shelf_high_thick+2 );

		// clearance for header pins
		translate([ 0, board_feather_width - header_window_y, -0.1 ]) cube([ header_window_x, header_window_y, cap_thick+0.2]);
		translate([ 0, -0.1, -0.1 ]) cube([ header_window_x, header_window_y, cap_thick+0.2]);
	}
}

module part_clicker_post() {
	cylinder(d=2.5, h=5 );
	cylinder(d=5, h=1);
}

module part_ls_shield() {
	led_dia = 5.3;
	sens_dia = 3.6;
	sens_cl = 1.0;
     
	difference() {
		union() {
			roundedbox( viewslot_line_x-1.5, viewslot_line_y-1.2, 2, plate_thick);
			translate([ 0, 0, plate_thick ]) 
				roundedbox( viewslot_line_x+ 3, viewslot_line_y+3, 2, 5);
			translate([ 0, 3, plate_thick ]) 
				roundedbox( sensor_mount_hole_spacing+8, 7, 2, 5);
		}
		translate([ -sensor_mount_hole_spacing/2, 3, -0.1]) cylinder(d=TI30_threaded_insert_dia, h=12);
		translate([  sensor_mount_hole_spacing/2, 3, -0.1]) cylinder(d=TI30_threaded_insert_dia, h=12);

		translate([  0, sens_cl-0.5, -0.1]) cylinder(d=led_dia, h=12);

		translate([  -5, sens_cl-0.8, -0.1]) cylinder(d=sens_dia, h=12);		
		translate([  +5, sens_cl-0.8, -0.1]) cylinder(d=sens_dia, h=12);

		translate([  -10, sens_cl-1.6, -0.1]) cylinder(d=led_dia, h=12);		
		translate([  +10, sens_cl-1.6, -0.1]) cylinder(d=led_dia, h=12);

		translate([  -15, sens_cl-3.4, -0.1]) cylinder(d=sens_dia, h=12);		
		translate([  +15, sens_cl-3.4, -0.1]) cylinder(d=sens_dia, h=12);
	}
} 

module part_marker_led_shield() {
	led_dia = 5.5;
	sens_dia = 3.9;
	sens_cl = 1.0;
	shield_thick = 7;
     
	difference() {
		roundedbox( 14, 7, 3, shield_thick);

		translate([  2.2, 0, -0.1]) cylinder(d=led_dia, h=12);
		translate([  -3.2, 0, -0.1]) cylinder(d=sens_dia, h=12);	
	}
} 


module fixture_pwr_dist_solder() {
	pin_dia = 1.5;
	fixture_thick = 9;

	difference() {
		roundedbox( 57, 30, 2, fixture_thick);
		for (i = [0 : 1 : 7]) {
		  // Code to be executed in each iteration
		  translate([ 2.54 * i, 0, -0.1 ]) cylinder(d=pin_dia, h=fixture_thick+0.2);
		  translate([ 2.54 * i, (2.54*1), -0.1 ]) cylinder(d=pin_dia, h=fixture_thick+0.2);
		  translate([ 2.54 * i, (2.54*2), -0.1 ]) cylinder(d=pin_dia, h=fixture_thick+0.2);
		  translate([ 2.54 * (i+1), (2.54*3), -0.1 ]) cylinder(d=pin_dia, h=fixture_thick+0.2);
		  translate([ 2.54 * (i+1), -(2.54*1), -0.1 ]) cylinder(d=pin_dia, h=fixture_thick+0.2);
		  translate([ 2.54 * (i+1), -(2.54*2), -0.1 ]) cylinder(d=pin_dia, h=fixture_thick+0.2);

		  translate([ -2.54 * (i+2), -(2.54*2), -0.1 ]) cylinder(d=pin_dia, h=fixture_thick+0.2);
		}
	}
    translate([ 0, -12.5,  fixture_thick ]) linear_extrude(1) text("Pwr Dist Strip v2", 
        size=5,  halign="center", font = "Liberation Sans:style=Bold");
}


module part_flyingplate_bicolor( lift = 6) {
	fp_x = 8;
	fp_y = 64;
	fp_thick = 3;

	bicolor_window_x = 32 + 1;
	bicolor_window_y = 32 + 1;
	bicolor_screw_x = 36;
	bicolor_screw_y = 28;

	difference() {
		hole_spacing_x = standoff_x;
		hole_spacing_y = (standoff_y_front - standoff_y_back)/2;

		union() {
			translate([ +hole_spacing_x, 0, 0 ]) roundedbox( fp_x, fp_y, 3, fp_thick);
			translate([ -hole_spacing_x, 0, 0 ]) roundedbox( fp_x, fp_y, 3, fp_thick);

			// mount plate for bicolor
			translate([ 0, -20, 0 ]) difference() {
				roundedbox( standoff_x * 2, 40, 3, fp_thick );
				translate([ 0, 0, -0.1 ]) roundedbox( bicolor_window_x, bicolor_window_y, 0.5, fp_thick + 0.2 );

				translate([ -(bicolor_screw_x/2), +(bicolor_screw_y/2), -0.1 ]) 
					cylinder( d=M2_throughhole_dia, h=fp_thick + 0.2);
				translate([ -(bicolor_screw_x/2), -(bicolor_screw_y/2), -0.1 ]) 
					cylinder( d=M2_throughhole_dia, h=fp_thick + 0.2);
				translate([ +(bicolor_screw_x/2), +(bicolor_screw_y/2), -0.1 ]) 
					cylinder( d=M2_throughhole_dia, h=fp_thick + 0.2);
				translate([ +(bicolor_screw_x/2), -(bicolor_screw_y/2), -0.1 ]) 
					cylinder( d=M2_throughhole_dia, h=fp_thick + 0.2);

				translate([ bicolor_screw_x/2, 0, fp_thick-1 ]) roundedbox( 4, 16, 1, fp_thick );
			}

		}

		// through holes in pillars (passthru for M3)
		translate([ 0, 0, 0 ]) union() {
			translate([ -(hole_spacing_x), +(hole_spacing_y), -0.1 ]) cylinder( d=M3_throughhole_dia, h=lift+fp_thick+0.2);
			translate([ -(hole_spacing_x), -(hole_spacing_y), -0.1 ]) cylinder( d=M3_throughhole_dia, h=lift+fp_thick+0.2);
			translate([ +(hole_spacing_x), +(hole_spacing_y), -0.1 ]) cylinder( d=M3_throughhole_dia, h=lift+fp_thick+0.2);
			translate([ +(hole_spacing_x), -(hole_spacing_y), -0.1 ]) cylinder( d=M3_throughhole_dia, h=lift+fp_thick+0.2);
		}
	}
}

module part_flyingplate_bicolor_feather (lift = 6) {
	fp_x = 8;
	fp_y = 64;
	fp_thick = 3;

	bicolor_window_x = 32 + 1;
	bicolor_window_y = 32 + 1;
	bicolor_screw_x = 36;
	bicolor_screw_y = 28;

	difference() {
		hole_spacing_x = standoff_x;
		hole_spacing_y = (standoff_y_front - standoff_y_back)/2;

		union() {
			translate([ +hole_spacing_x, 0, 0 ]) roundedbox( fp_x, fp_y, 3, fp_thick);
			translate([ -hole_spacing_x, 0, 0 ]) roundedbox( fp_x, fp_y, 3, fp_thick);

			// mount plate for bicolor
			translate([ 0, -22, 0 ]) difference() {	
				translate([ 0, 2.5, 0 ]) roundedbox( standoff_x * 2, 45, 3, fp_thick );
				translate([ -13, 2, -0.1 ]) union() {
					roundedbox( bicolor_window_x, bicolor_window_y, 0.5, fp_thick + 2.2 );

					translate([ -(bicolor_screw_x/2), +(bicolor_screw_y/2), 0 ]) 
						cylinder( d=M2_throughhole_dia, h=fp_thick + 0.2);
					translate([ -(bicolor_screw_x/2), -(bicolor_screw_y/2), 0 ]) 
						cylinder( d=M2_throughhole_dia, h=fp_thick + 0.2);
					translate([ +(bicolor_screw_x/2), +(bicolor_screw_y/2), 0 ]) 
						cylinder( d=M2_throughhole_dia, h=fp_thick + 0.2);
					translate([ +(bicolor_screw_x/2), -(bicolor_screw_y/2), 0 ]) 
						cylinder( d=M2_throughhole_dia, h=fp_thick + 0.2);

					//translate([ bicolor_screw_x/2, 0, fp_thick-1 ]) roundedbox( 4, 16, 1, fp_thick );
					translate([ -(bicolor_screw_x/2), 0, 0 ]) roundedbox( 4, 16, 1, fp_thick+-1 );
				}
			}
			translate([ 21, -15, 0 ]) rotate([ 0, 0,  90 ]) component_feather( 8 );
		}

		// through holes in pillars (passthru for M3)
		translate([ 0, 0, 0 ]) union() {
			translate([ -(hole_spacing_x), +(hole_spacing_y), -0.1 ]) cylinder( d=M3_throughhole_dia, h=lift+fp_thick+0.2);
			translate([ -(hole_spacing_x), -(hole_spacing_y), -0.1 ]) cylinder( d=M3_throughhole_dia, h=lift+fp_thick+0.2);
			translate([ +(hole_spacing_x), +(hole_spacing_y), -0.1 ]) cylinder( d=M3_throughhole_dia, h=lift+fp_thick+0.2);
			translate([ +(hole_spacing_x), -(hole_spacing_y), -0.1 ]) cylinder( d=M3_throughhole_dia, h=lift+fp_thick+0.2);
		}
	}
}

module part_flyingplate_bicolor_sparkfun (lift = 6) {
	fp_x = 8;
	fp_y = 64;
	fp_thick = 3;

	bicolor_window_x = 32 + 1;
	bicolor_window_y = 32 + 1;
	bicolor_screw_x = 36;
	bicolor_screw_y = 28;

	difference() {
		hole_spacing_x = standoff_x;
		hole_spacing_y = (standoff_y_front - standoff_y_back)/2;

		union() {
			translate([ +hole_spacing_x, 0, 0 ]) roundedbox( fp_x, fp_y, 3, fp_thick);
			translate([ -hole_spacing_x, 0, 0 ]) roundedbox( fp_x, fp_y, 3, fp_thick);

			// mount plate for bicolor
			translate([ 0, -22, 0 ]) difference() {	
				translate([ 0, 2.5, 0 ]) roundedbox( standoff_x * 2, 45, 3, fp_thick );
				translate([ -13, 3, -0.1 ]) union() {
					roundedbox( bicolor_window_x, bicolor_window_y, 0.5, fp_thick + 2.2 );

					translate([ -(bicolor_screw_x/2), +(bicolor_screw_y/2), 0 ]) 
						cylinder( d=M2_throughhole_dia, h=fp_thick + 0.2);
					translate([ -(bicolor_screw_x/2), -(bicolor_screw_y/2), 0 ]) 
						cylinder( d=M2_throughhole_dia, h=fp_thick + 0.2);
					translate([ +(bicolor_screw_x/2), +(bicolor_screw_y/2), 0 ]) 
						cylinder( d=M2_throughhole_dia, h=fp_thick + 0.2);
					translate([ +(bicolor_screw_x/2), -(bicolor_screw_y/2), 0 ]) 
						cylinder( d=M2_throughhole_dia, h=fp_thick + 0.2);

					translate([ -(bicolor_screw_x/2), 0, 0 ]) roundedbox( 4, 16, 1, fp_thick+-1 );
				}
			}
			translate([ 21, -28, 0 ]) rotate([ 0, 0,  90 ]) component_sparkfun_nav_switch( 8 );
		}

		// through holes in pillars (passthru for M3)
		translate([ 0, 0, 0 ]) union() {
			translate([ -(hole_spacing_x), +(hole_spacing_y), -0.1 ]) cylinder( d=M3_throughhole_dia, h=lift+fp_thick+0.2);
			translate([ -(hole_spacing_x), -(hole_spacing_y), -0.1 ]) cylinder( d=M3_throughhole_dia, h=lift+fp_thick+0.2);
			translate([ +(hole_spacing_x), +(hole_spacing_y), -0.1 ]) cylinder( d=M3_throughhole_dia, h=lift+fp_thick+0.2);
			translate([ +(hole_spacing_x), -(hole_spacing_y), -0.1 ]) cylinder( d=M3_throughhole_dia, h=lift+fp_thick+0.2);
		}
	}
}