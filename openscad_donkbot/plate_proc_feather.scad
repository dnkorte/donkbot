/*
 * Module: plate_proc_feather.scad
 * this file has generators for components used in DonKbot_mm projects,
 * specifically it generates plates that include processor modules
 * from the Adafruit Feather line of processors including ESP32, as well as power 
 * switches, i2c hubs, etc that are closely related to the processor
 * or signal processing functions.  it includes plates that are used 
 * in support of 3-board stacks where batteries and power switches are 
 * assumed to live on the "2nd-level" board, and it includes plates 
 * using the newer 2-board stack series (in which tha battery and power
 * switching function is included on the processor plate)
 *
 * Note that when using a 2-plate modeule there is usually a smaller
 * "flying plate" that mounts above the "top" plate (processor) and 
 * includes the user interface elements (the philosophy being that 
 * the flying plate has very few interconnections, and the bulk of the
 * wiring harnesss run between the motor plate and processor plate.  this
 * greatly simplifies the wire routing issues)
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

//plate_proc_feather_proto();
//plate_proc_dual_feathers();
//plate_proc_feather_back();
//plate_proc_feather_mid();			// single usb/batt switch
//plate_proc_feather_mid( 2 );		// dual usb/batt switch (ie for qtpy on bottom plate)
//plate_proc_feather_batt( 1 );		// dual usb/batt switch (ie for qtpy on bottom plate)
plate_proc_feather_batt( 0, true);

/*
 ********************************************************************
 * modules creating plates
 ********************************************************************
 */



/*
 * module plate_proc_feather() generates a plate containing an Adafruit 
 * Feather formfactor board and a Small Mint Tin sized protoboard for 
 * small parts such as encoder XOR or header connectors, etc
 * It also includes power USB-vs-battery switch and an i2c distribution board.
 *
 * it is originally used to hold an ESP32-S2 reverse TFT board which includes
 * an ESP32-S2 processor along with a 240 x 135 TFT and 3 tactile pushbuttons
 */

module plate_proc_feather_proto() {
	difference() {
		union() { 
			component_plate( "C", 0 );		
			translate([ 24, 50, plate_thick ]) color([ 0, 0, 1 ])  component_i2c_hub();

			translate([ 0, 80, plate_thick ]) color([ 1, 0, 0 ]) component_feather_reverse_tft();

			translate([ -5, 18, plate_thick ]) color([ 0, 0, 1 ]) component_smallmintproto();

			translate([ -27, 51, plate_thick ])  rotate([ 0, 0, -90 ]) component_power_selector_mount( true );

	        //translate([-33, 58, plate_thick]) linear_extrude(2) text("USB", 
	        //    size=5,  halign="center", font = "Liberation Sans:style=Bold");
	        //translate([-33, 40, plate_thick]) linear_extrude(2) text("BAT", 
	        //    size=5,  halign="center", font = "Liberation Sans:style=Bold");
		}

		// big wire passthru hole
		translate([ 28, 19, -0.1 ]) 
			roundedbox( 8, 33, 2, plate_thick+0.2);

		// small wire passthru hole for int/ext power for feather
		translate([ 0, 50, -0.1 ]) 
			roundedbox( 16, 16, 2, plate_thick+0.2);

		// front wire passthru hole for int/ext power for feather
		translate([ 0, 96, -0.1 ]) 
			roundedbox( 30, 5, 2, plate_thick+0.2);
			
		// mounting holes for front accessory
		translate([ -accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );
		translate([  accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );
	}
}


/*
 * module plate_proc_feather_back() generates a plate containing an Adafruit 
 * Feather formfactor board and a Small Mint Tin sized protoboard for 
 * small parts such as encoder XOR or header connectors, etc
 * It also includes power USB-vs-battery switch and an i2c distribution board.
 *
 * it is originally used to hold an ESP32-S2 reverse TFT board which includes
 * an ESP32-S2 processor along with a 240 x 135 TFT and 3 tactile pushbuttons
 */

module plate_proc_feather_back() {
	difference() {
		union() { 
			component_plate( "C", 0 );		
			translate([ 24, 50, plate_thick ]) color([ 0, 0, 1 ])  component_i2c_hub();
			translate([ -5, 16, plate_thick ]) color([ 1, 0, 0 ]) component_feather_reverse_tft();
			translate([ -27, 51, plate_thick ])  rotate([ 0, 0, -90 ]) component_power_selector_mount( true );
		}

		// back wire passthru hole
		translate([ 28, 19, -0.1 ]) 
			roundedbox( 8, 33, 2, plate_thick+0.2);

		// middle wire passthru hole for int/ext power for feather
		translate([ 0-5, 50, -0.1 ]) 
			roundedbox( 26, 30, 2, plate_thick+0.2);

		// front wire passthru hole for int/ext power for feather
		translate([ 0, 94, -0.1 ]) 
			roundedbox( 30, 10, 2, plate_thick+0.2);
			
		// mounting holes for front accessory
		translate([ -accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );
		translate([  accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );
	}
}

/*
 * module plate_proc_feather_mid() generates a plate containing an Adafruit 
 * Feather formfactor board and a Small Mint Tin sized protoboard for 
 * small parts such as encoder XOR or header connectors, etc
 * It also includes power USB-vs-battery switch and an i2c distribution board.
 *
 * it is originally used to hold an ESP32-S2 reverse TFT board which includes
 * an ESP32-S2 processor along with a 240 x 135 TFT and 3 tactile pushbuttons
 */

module plate_proc_feather_mid( num_pwr_source_switches = 1 ) {
	difference() {
		union() {  
			component_plate( "C", 0 );			
			translate([ 2, 18, plate_thick ]) color([ 0, 0, 1 ])  rotate([ 0, 0, 90 ]) component_i2c_hub();
			translate([ 0, 54, plate_thick ]) color([ 1, 0, 0 ]) component_feather_reverse_tft();
			if ( num_pwr_source_switches == 1) {
				translate([ -20, 14, plate_thick ])  rotate([ 0, 0, 0 ]) component_power_selector_mount( true );
			} else {
				translate([ -20, 14, plate_thick ])  rotate([ 0, 0, 0 ]) component_power_selector_mount_dual( true );
			}
		}

		// back right wire passthru hole
		translate([ 23, 19, -0.1 ]) 
			roundedbox( 17, 29, 2, plate_thick+0.2);

		// back left wire passthru hole
		translate([ -20, 26, -0.1 ]) 
			roundedbox( 19, 15, 2, plate_thick+0.2);

		// front wire passthru hole
		//translate([ 0, 96, -0.1 ]) 
		//	roundedbox( 30, 5, 2, plate_thick+0.2);

		// front wire passthru hole for int/ext power for feather
		translate([ 0, 75, -0.1 ]) 
			roundedbox( 54, 12, 2, plate_thick+0.2);
			
		// mounting holes for front accessory
		translate([ -accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );
		translate([  accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );
	}
}


/*
 * module plate_plate_proc_dual_feathers() generates a plate containing 2 Adafruit 
 * Feather formfactor boards 
 * It also includes 2 power USB-vs-battery switches and an i2c distribution board
 *
 * it is originally used to hold an ESP32-S2 reverse TFT board which includes
 * an ESP32-S2 processor along with a 240 x 135 TFT and 3 tactile pushbuttons,
 * to be used as main processor, and another Feather board such as an RP2040 Feather
 * which is used to provide dedicated motor control (or any other function needed)
 */

module plate_proc_dual_feathers() {
	difference() {
		union() { 
			component_plate( "C", 0 );		
			translate([ 15, 31, plate_thick ]) color([ 0, 0, 1 ])  component_i2c_hub();
			translate([ 0, 79, plate_thick ]) color([ 1, 0, 0 ]) component_feather_reverse_tft( );	
			translate([ -18, 28, plate_thick ]) color([ 1, 0, 0 ]) rotate ([ 0, 0, 90 ]) component_feather( );	
	        translate([ 27, 53, plate_thick ]) rotate([ 0, 0, 90 ]) component_power_selector_mount_dual(true);

	        translate([ 33, 84, plate_thick]) linear_extrude(2) rotate ([ 0, 0, 90 ])text("^ MAIN", 
	            size=5,  halign="center", font = "Liberation Sans:style=Bold");
	        translate([ 39, 83, plate_thick]) linear_extrude(2) rotate ([ 0, 0, 90 ])text("v MOT", 
	            size=5,  halign="center", font = "Liberation Sans:style=Bold");
		}

		// back wire passthru hole
		translate([ 14, 11, -0.1 ]) 
			roundedbox( 28, 14, 2, plate_thick+0.2);

		// middle wire passthru hole 
		translate([ -8, 60.5, -0.1 ]) 
			roundedbox( 48, 10, 2, plate_thick+0.2);

		// front wire passthru hole
		//translate([ 0, 96, -0.1 ]) 
		//	roundedbox( 30, 5, 2, plate_thick+0.2);
			
		// mounting holes for front accessory
		translate([ -accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );
		translate([  accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );
	}
}


/*
 * module plate_proc_feather_batt() generates a plate containing an Adafruit 
 * Feather formfactor board and battery and power distribution, plus both switches
 * It also includes  i2c distribution board.
 *
 * THIS  USED IN A 2-BOARD STACK
 * (note that it does not include wheel cutouts, so the motor board pillars must
 * be tall enough to provide clearance for wheels)
 * (note also that this does not provide holes from mounting front attachment)
 *
 * it is originally used to hold an ESP32-S2 reverse TFT board which includes
 * an ESP32-S2 processor along with a 240 x 135 TFT and 3 tactile pushbuttons
 */

module plate_proc_feather_batt( num_pwr_source_switches = 1, wantFlyingBoard = false ) {
	power_strip_x = 23;
	power_strip_y = 28;

	difference() {
		union() {  
			if (wantFlyingBoard) {
				component_plate( "A", 30 );	
			} else {				
				component_plate( "D", 0 );	
			}		
			translate([ -3, 62, plate_thick ]) color([ 1, 0, 1 ]) rotate([ 0, 0, 0 ]) component_i2c_hub();
			translate([ 14, 87, plate_thick ]) color([ 0, 1, 1 ]) component_feather_reverse_tft();

			// support the feather (square up the diagonal front right corner)
			translate([ 29, 90, 0 ]) cube([ 12.5, 12, plate_thick ]);	

			if ( num_pwr_source_switches == 1) {
				translate([ -25, 87, plate_thick ])  rotate([ 0, 0, 180 ]) component_power_selector_mount( true );
			} else if ( num_pwr_source_switches == 2) {
				translate([ -25, 87, plate_thick ])  rotate([ 0, 0, 180 ]) component_power_selector_mount_dual( true );
			} else {
				// no switch (must use usb power blocker...)
			}
	        translate([ -28, 13, plate_thick ])  component_power_switch_mount( true );

			translate([ -4, 0, plate_thick ]) color([ 1, 0, 0 ]) component_9v_batt();

			translate([ power_strip_x, power_strip_y, plate_thick ]) color([ 0, 1, 0 ]) 
				rotate([ 0, 0, 90 ]) component_dts_pwrdist( 4, "adds");
		}

		// back right wire passthru hole
		//translate([ 23, 19, -0.1 ]) 
		//	roundedbox( 17, 29, 2, plate_thick+0.2);

		// front right wire passthru hole
		translate([ 22, 64, -0.1 ]) 
			roundedbox( 18, 14, 2, plate_thick+0.2);

		// back left wire passthru hole
		translate([ -28, 38, -0.1 ]) 
			roundedbox( 16, 36, 2, plate_thick+0.2);

		// front wire left passthru hole for int/ext power for feather
		if (num_pwr_source_switches > 0 ) {
			translate([ -25, 74, -0.1 ]) 
				roundedbox( 14, 16, 2, plate_thick+0.2);
		} else {		
			translate([ -25, 84, -0.1 ]) 
				roundedbox( 14, 20, 2, plate_thick+0.2);
		}
			
		// mounting holes for front accessory
		//translate([ -accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );
		//translate([  accessory_mount_spacing/2, 97, -0.1 ]) cylinder( d=M3_throughhole_dia, h=plate_thick+0.2 );

		// holes for power distribution strip
		translate([ power_strip_x, power_strip_y, plate_thick ]) 
			rotate([ 0, 0, 90 ]) component_dts_pwrdist( 4, "holes");
	}
}