/*
 * Module: plate_batt_9v.scad
 * this file has generators for components used in DonKbot_mm projects,
 * specifically it generates plates that include batteries, power switches,
 * power distribution boards etc (typically used in 3-board stacks where the
 * board sequence includes motor plate -> battery plate -> processor and 
 * interaction plate)
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
 *	20241204 - Initial Release
 */

include <dkb_core.scad>;

// set visualizations flag (normally false, and should definitely be false when rendering for print)
// if true it shows the "bodies" of some parts to aid in visualizing spacing when settiup up plates
// currently used by plate_motors_nema8_stepper() and component_motormount_TT()
show_viz = false;

// (possibly) over-ride configuration 
TI20_use_threaded_insert = true;
TI25_use_threaded_insert = true;
TI30_use_threaded_insert = true;



/*
 ********************************************************************
 * select the part to be rendered
 ********************************************************************
 */

//plate_battery_9v( 25, 37, "N20" );
//plate_battery_9v( 25, 34, "TT" );
plate_battery_9v( 25, 0 );



/*
 *  
 * 
 * NOTE that the pillars extend "height" above the plate's top surface
 */
module plate_battery_9v( pillar_height, wheel_axis = 0, wheel_label = "" ) {
	power_strip_x = 0;
	power_strip_y = 65;
	wheel_x = 7;	// wheel hole "width"
	wheel_y = 28;	// wheel hole "length"
	wheel_adj = 4;	// this makes wheel slot fatter to eliminate round corner on outside edge

	difference() {
		union() { 
			component_plate( "A", pillar_height );
	        translate([ -24, 15, plate_thick ])  component_power_switch_mount( true );
			translate([ 0, 3, plate_thick ]) color([ 1, 0, 0 ]) component_9v_batt();
			translate([ power_strip_x, power_strip_y, plate_thick ]) color([ 0, 0, 1 ]) component_dts_pwrdist( 4, "adds");

			if (wheel_axis == 0) {
				// mounts for voltage regulators
				translate([ 22, 50, plate_thick ]) M25_mount_cyl_with_bolthole( 7 );  
		        translate([22, 41, plate_thick]) linear_extrude(1) text("M25", 
		            size=4,  halign="center", font = "Liberation Sans:style=Bold");
		        if (show_viz) {
		        	translate([ 22, 50-6, plate_thick+7 ]) color ([ 1, 0, 1 ]) roundedbox( 10, 18, 2, 2);
		        }

				translate([ 34, 50, plate_thick ]) M25_mount_cyl_with_bolthole( 7 );  
		        translate([34, 41, plate_thick]) linear_extrude(1) text("M25", 
		            size=4,  halign="center", font = "Liberation Sans:style=Bold");
		        if (show_viz) {
		        	translate([ 34, 50-6, plate_thick+7 ]) color ([ 1, 0, 1 ]) roundedbox( 10, 18, 2, 2);
		        }
	 
		        translate([28, 35, plate_thick]) linear_extrude(1) text("V Regul", 
		            size=4,  halign="center", font = "Liberation Sans:style=Bold");
		    } else {
				// mounts for voltage regulators
				translate([ 20, 50, plate_thick ]) M25_mount_cyl_with_bolthole( 7 );  
		        translate([20+8, 50, plate_thick]) rotate([ 0, 0, 90 ]) linear_extrude(1) text("M25", 
		            size=4,  halign="center", font = "Liberation Sans:style=Bold");
		        if (show_viz) {
		        	translate([ 20+6, 50, plate_thick+7 ]) color ([ 1, 0, 1 ]) roundedbox( 18, 10, 2, 2);
		        }

				translate([ 20, 38, plate_thick ]) M25_mount_cyl_with_bolthole( 7 );  
		        translate([ 20+8, 38, plate_thick]) rotate([ 0, 0, 90 ]) linear_extrude(1) text("M25", 
		            size=4,  halign="center", font = "Liberation Sans:style=Bold");
		        if (show_viz) {
		        	translate([ 20+6, 38, plate_thick+7 ]) color ([ 1, 0, 1 ]) roundedbox( 18, 10, 2, 2);
		        }
	 
		        translate([20+13, 44, plate_thick]) rotate([ 0, 0, 90 ]) linear_extrude(1) text("V Regul", 
		            size=4,  halign="center", font = "Liberation Sans:style=Bold");
		    }
		    translate([ -(plate_x/2)+5.5, wheel_axis + (wheel_y/2) + 1.5, plate_thick]) 
		    	linear_extrude(1) text(wheel_label, size=4,  halign="center", font = "Liberation Sans:style=Bold");
		}

		// wire and connector passthru for sensor boards
		translate([ 0, 84, -0.1 ]) 
			roundedbox( 52, 16, 2, plate_thick+0.2);

		// middle passthru
		translate([ -24, 40, -0.1 ]) 
			roundedbox( 14, 28, 2.5, plate_thick + 0.2);

		// back wire passthru
		translate([ 24, 17, -0.1 ]) 
			roundedbox( 14, 28, 2.5, plate_thick + 0.2);

		// holes for power distribution strip
		translate([ power_strip_x, power_strip_y, plate_thick ]) component_dts_pwrdist( 4, "holes");

		// mounting holes for front accessory
		translate([ -accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );
		translate([  accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );

		// wheel holes
		if (wheel_axis > 0) {
			translate([ -(plate_x/2) + (wheel_x/2) - (wheel_adj/2), wheel_axis, -0.1 ]) 
				roundedbox( wheel_x + wheel_adj, wheel_y, 2, plate_thick+0.2 );
			translate([  (plate_x/2) - (wheel_x/2) + (wheel_adj/2), wheel_axis, -0.1 ]) 
				roundedbox( wheel_x + wheel_adj, wheel_y, 2, plate_thick+0.2 );
		}
	}
}