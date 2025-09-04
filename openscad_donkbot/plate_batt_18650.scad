/*
 * Module: plate_batt_18650.scad
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
plate_battery_18650( 25, "5v", true);
//plate_battery_18650_fused( 25, "5v", false);
//part_fuse_holder_lid();
//component_fuse_holder_block("passthrough");
//part_batt_18650_door();	// note this and many subcomponents live in dkb_lib_parts_switches_batts.scad



/*
 *  
 * 
 * NOTE that the pillars extend "height" above the plate's top surface
 */
module plate_battery_18650( pillar_height, vbat = "5v", wantWheelHoles = false ) {
	power_strip_x = 23;
	power_strip_y = 54;

	difference() {
		union() { 
			component_plate( "A", pillar_height );

			// power switch
	        translate([ -24, 91, plate_thick ]) rotate([ 0, 0, -90 ]) component_power_switch_mount( false );
	        translate([-35, 92, plate_thick]) rotate([ 0, 0, -135 ]) linear_extrude(2) text("PWR", 
	            size=5,  halign="center", font = "Liberation Sans:style=Bold");

			translate([ -30, 82, plate_thick ]) rotate([ 0, 0, -90 ]) color([ 1, 0, 0 ]) component_batt_18650_mount();

			translate([ power_strip_x, power_strip_y, plate_thick ]) color([ 0, 0, 1 ]) rotate([ 0, 0, 90 ]) component_dts_pwrdist( 4, "adds");

			translate([ 14, 92, plate_thick ]) M25_mount_cyl_with_bolthole( 7 );  
	        translate([23, 88, plate_thick]) linear_extrude(2) text(vbat, 
	            size=5,  halign="center", font = "Liberation Sans:style=Bold");
		}

		// wire passthru (back)
		translate([ 22, 14, -0.1 ]) 
			roundedbox( 16, 18, 2.5, plate_thick + 0.2);

		// wire passthru (front)
		translate([ -3, 91, -0.1 ]) 
			roundedbox( 24, 12, 2.5, plate_thick + 0.2);

		// holes for power distribution strip
		translate([ power_strip_x, power_strip_y, plate_thick ]) rotate([ 0, 0, 90 ]) component_dts_pwrdist( 4, "holes");

		// clearance openings for tops of wheels
		//if (wantWheelHoles) {
		//	translate([ (plate_x/2)-3, wheel_y, -0.1 ]) 
		//		roundedbox( 8, 30, 2, plate_thick + 0.2);
		//	translate([ -(plate_x/2)+3, wheel_y, -0.1 ]) 
		//		roundedbox( 8, 30, 2, plate_thick + 0.2);
		//}
	}
}

/* 
 * NOTE that the pillars extend "height" above the plate's top surface
 */
module plate_battery_18650_fused( pillar_height, vbat = "5v", wantWheelHoles = false ) {
	power_strip_x = -4;
	power_strip_y = 92;

	difference() {
		union() { 
			component_plate( "A", pillar_height );

			// power switch
	        translate([ 28, 82, plate_thick ]) rotate([ 0, 0, 180 ]) component_power_switch_mount( false );
	        translate([35, 92, plate_thick]) rotate([ 0, 0, 135 ]) linear_extrude(2) text("PWR", 
	            size=5,  halign="center", font = "Liberation Sans:style=Bold");

			translate([ -30, 82, plate_thick ]) rotate([ 0, 0, -90 ]) color([ 1, 0, 0 ]) component_batt_18650_mount();

			translate([ power_strip_x, power_strip_y, plate_thick ]) color([ 0, 0, 1 ]) rotate([ 0, 0, 0 ]) component_dts_pwrdist( 4, "adds");
	        translate([-37, power_strip_y-5, plate_thick]) rotate([ 0, 0, -90 ]) linear_extrude(2) text("M3", 
	            size=4,  halign="center", font = "Liberation Sans:style=Bold");

			if (wantWheelHoles) {
				translate([ 25.5, 40, plate_thick ]) rotate([ 0, 0, 0 ]) color([ 0, 1, 0 ]) component_fuse_holder_mount( 5 );
			} else {
				translate([ 30, 40, plate_thick ]) rotate([ 0, 0, 0 ]) color([ 0, 1, 0 ]) component_fuse_holder_block("auto" );
			}
	        translate([ 33, 20.5, plate_thick]) linear_extrude(2) text("M3", 
	            size=4,  halign="center", font = "Liberation Sans:style=Bold");

			translate([ -36, 40, plate_thick ]) M25_mount_cyl_with_bolthole( 7 );  
	        translate([-36, 30, plate_thick]) linear_extrude(2) text(vbat, 
	            size=5,  halign="center", font = "Liberation Sans:style=Bold");
	        translate([-36, 46, plate_thick]) linear_extrude(2) text("M25", 
	            size=4,  halign="center", font = "Liberation Sans:style=Bold");
		}

		// wire passthru (back)
		translate([ 21, 14, -0.1 ]) 
			roundedbox( 14, 18, 2.5, plate_thick + 0.2);

		// wire passthru (front)
		translate([ 23, 67, -0.1 ]) 
			roundedbox( 18, 18, 2.5, plate_thick + 0.2);

		// holes for power distribution strip
		translate([ power_strip_x, power_strip_y, plate_thick ]) color([ 0, 0, 1 ]) rotate([ 0, 0, 0 ]) component_dts_pwrdist( 4, "holes");

	}
}