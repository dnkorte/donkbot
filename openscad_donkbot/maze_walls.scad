/*
 * Module: plate_maze_walls.scad
 * this file has generators for components used in DonKbot_mm projects,
 * specifically it generates parts used in generating maze pillars
 * and templates for drilling maze  bases. Note that this generates
 * parts to support maze walls using either the standard 12mm walls
 * and for mazes using US standard 3/4 inch ("1 by 2") walls that 
 * are much easier and quicker to build (though bots that rely heavily
 * on the standard size and / or surface reflectivity of the UKMARS
 * walls will probably not perform well with simple wood walls) 
 *
 * view maze construction at https://photos.app.goo.gl/D5PgzwZijvFSpFg68
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
 *  https://donstechstuff.com/
 *  https://photos.app.goo.gl/n3T1WMVK3Vmwz7cS7  photo album random pics donkbot parts etc
 *  https://photos.app.goo.gl/D5PgzwZijvFSpFg68  photo album maze fabrication
 *  https://openscad.org/
 *  https://donstechstuff.com
 *
 * Version History:
 *	20241204 - Initial Release
 */

include <dkb_core.scad>;

//drill_template();
//drill_template_starter();
//drill_template_starter_with_guide();
//drill_template_with_guide();
//locator_peg_insert();
//peg_19mm();
//peg_12mm(); 
//peg_12mm( true );  
peg_19mm_12mm_transition();
//drill_sizer();

peg_thick = 12.6;
peg_height = 50;
slot_width = 4;
slot_depth = 2;
tri_slot_dim = 3.5;	// length of side of triangle slot BEFORE rotating (hypotenuse = 1.414 * this)

clearance_gap_length = 1.0;
wall_length = 180 - peg_thick - clearance_gap_length;
//wall_length = 50 - peg_thick - clearance_gap_length;
wall_thick = 12;
wall_height = 50;
tab_width = 3;
tab_depth = 2.5;
tri_tab_dim = 3.0;	// length of side of triangle tab BEFORE rotating (hypotenuse = 1.414 * this)

// locator pin and guide dimensions for hole drilling templates
locator_peg_insert_hole_dia = 9.9;
locator_pin_dia = (0.375 * 25.4) - 0.1;
drill_diameter = 9.9;	// for drill tower 
locator_tower_height = 50;
locator_tower_dia = 24;
locator_thick = 5;



/*
 * this is a peg for simple wall system for US
 * maze walls use 1x2 lumper with 3/8 in tenons.   this is fatter than standard by 6mm and shorter by abotu 12mm
 * but reasonable for testing, and really cheap
 * peg pins are for 3/8 drill
 */

module peg_19mm() {
	wall_thick = 0.75 * 25.4;
	wall_height = 1.5 * 25.4;
	//wall_height = 7;
	slot_width = (0.25 * 25.4) + 1;
	slot_depth = 3.5;
	pin_dia = (0.375 * 25.4) + 0.20;
	pin_thick = 6; 

	difference() {
		union() {
			roundedbox(wall_thick, wall_thick, 2, wall_height);
			translate([ 0, 0, wall_height ]) cylinder( d=pin_dia, h=pin_thick );
		}
		translate([ (wall_thick/2) - slot_depth, 0 - (slot_width/2), -0.1]) 
			cube([ slot_width, slot_width, wall_height + 0.2 ]);
		translate([ -(wall_thick/2) - slot_width + slot_depth, 0 - (slot_width/2), -0.1]) 
			cube([ slot_width, slot_width, wall_height + 0.2 ]);

		translate([ -(slot_width/2), (wall_thick/2) - slot_depth, -0.1]) 
			cube([ slot_width, slot_width, wall_height + 0.2 ]);
		translate([ -(slot_width/2), -(wall_thick/2) - slot_width + slot_depth, -0.1]) 
			cube([ slot_width, slot_width, wall_height + 0.2 ]);
	}
}


module peg_12mm( with_pad=false) {
	wall_thick = 12;
	wall_height = 37;
	slot_width = (3.5) + 1;
	slot_extends = 15;
	slot_depth = 2.5;
	pin_dia = (0.375 * 25.4) + 0.20;
	pin_thick = 6;

	difference() {
		union() {
			roundedbox(wall_thick, wall_thick, 2, wall_height);
			translate([ 0, 0, wall_height ]) cylinder( d=pin_dia, h=pin_thick );
			if (with_pad) {
				cylinder( d=20, h=1);	// stabilizing pad for 3d printing support
				roundedbox( 20, 20, 2, 1);	// stabilizing pad for 3d printing support
			}

			if (false) 	{		// just temporary, to help figure out where to put pieces)
				translate([ (wall_thick/2) - slot_depth, 0 + (slot_width/2), -0.1]) rotate([ 0, 0, -90 ]) color([ 1, 0, 0])
					cube([ slot_width, slot_extends, wall_height + 0.2 ]);
				translate([ -(wall_thick/2)  + slot_depth, 0 - (slot_width/2), -0.1])  rotate([ 0, 0, 90 ]) color([ 0, 1, 0])
					cube([ slot_width, slot_extends, wall_height + 0.2 ]);

				translate([ -(slot_width/2), (wall_thick/2) - slot_depth, -0.1])  color([ 0, 0, 1])
					cube([ slot_width, slot_extends, wall_height + 0.2 ]);
				translate([ -(slot_width/2), -(wall_thick/2) - slot_extends + slot_depth, -0.1])  color([ 0.5, 0.5, 0.5])
					cube([ slot_width, slot_extends, wall_height + 0.2 ]);
			}

		}
		if (false) {
			translate([ (wall_thick/2) - slot_depth, 0 - (slot_width/2), -0.1]) 
				cube([ slot_width, slot_depth, wall_height + 0.2 ]);
			translate([ -(wall_thick/2) - slot_width + slot_depth, 0 - (slot_width/2), -0.1]) 
				cube([ slot_width, slot_depth, wall_height + 0.2 ]);

			translate([ -(slot_width/2), (wall_thick/2) - slot_depth, -0.1]) 
				cube([ slot_width, slot_width, wall_height + 0.2 ]);
			translate([ -(slot_width/2), -(wall_thick/2) - slot_width + slot_depth, -0.1]) 
				cube([ slot_width, slot_width, wall_height + 0.2 ]);
		}

		translate([ (wall_thick/2) - slot_depth, 0 + (slot_width/2), -0.1]) rotate([ 0, 0, -90 ]) color([ 1, 0, 0])
			cube([ slot_width, slot_extends, wall_height + 0.2 ]);
		translate([ -(wall_thick/2)  + slot_depth, 0 - (slot_width/2), -0.1])  rotate([ 0, 0, 90 ]) color([ 0, 1, 0])
			cube([ slot_width, slot_extends, wall_height + 0.2 ]);

		translate([ -(slot_width/2), (wall_thick/2) - slot_depth, -0.1])  color([ 0, 0, 1])
			cube([ slot_width, slot_extends, wall_height + 0.2 ]);
		translate([ -(slot_width/2), -(wall_thick/2) - slot_extends + slot_depth, -0.1])  color([ 0.5, 0.5, 0.5])
			cube([ slot_width, slot_extends, wall_height + 0.2 ]);
	}
}

/*
 * this is a peg for simple wall system for US
 * maze walls use 1x2 lumper with 3/8 in tenons.   this is fatter than standard by 6mm and shorter by abotu 12mm
 * but reasonable for testing, and really cheap
 * peg pins are for 3/8 drill
 */

module peg_19mm_12mm_transition() {
	wall_thick = 0.75 * 25.4;
	wall_height = 1.5 * 25.4;
	slot_width = (0.25 * 25.4) + 1;
	slot_depth = 3.5;
	pin_dia = (0.375 * 25.4) + 0.20;
	pin_thick = 6; 
	slot2_width = (3.5) + 1;	// the skinny slot
	slot2_extends = 15;			// the skinny slot
	slot2_depth = 2.5;			// the skinny slot

	difference() {
		union() {
			roundedbox(wall_thick, wall_thick, 2, wall_height);
			translate([ 0, 0, wall_height ]) cylinder( d=pin_dia, h=pin_thick );
		}
		translate([ (wall_thick/2) - slot2_depth, 0 - (slot2_width/2), -0.1]) 
			cube([ slot2_width, slot2_width, wall_height + 0.2 ]);
		translate([ -(wall_thick/2) - slot_width + slot_depth, 0 - (slot_width/2), -0.1]) 
			cube([ slot_width, slot_width, wall_height + 0.2 ]);

		translate([ -(slot_width/2), (wall_thick/2) - slot_depth, -0.1]) 
			cube([ slot_width, slot_width, wall_height + 0.2 ]);
		translate([ -(slot_width/2), -(wall_thick/2) - slot_width + slot_depth, -0.1]) 
			cube([ slot_width, slot_width, wall_height + 0.2 ]);
	}
}



module drill_template() {
	center_punch_dia = 2.5;
	grid_spacing = 180;
	leg_width = 30;
	half_grid = grid_spacing / 2;

	difference() {
		roundedbox( grid_spacing+leg_width, grid_spacing+leg_width, 4, locator_thick);
		translate([ 0, 0, -0.1 ]) roundedbox( grid_spacing-(leg_width/2), grid_spacing-(leg_width/2), 4, locator_thick+0.2);
		translate([ half_grid, half_grid, -0.1 ]) cylinder( d=center_punch_dia, h=locator_thick+0.2);
		translate([ -half_grid, half_grid, -0.1 ]) cylinder( d=center_punch_dia, h=locator_thick+0.2);
	}
	translate([ half_grid, -half_grid, locator_thick]) cylinder( d=locator_pin_dia, h=4);
	translate([ -half_grid, -half_grid, locator_thick ]) cylinder( d=locator_pin_dia, h=4);
}

module drill_template_with_guide() {
	center_punch_dia = 2.5;
	grid_spacing = 180;
	leg_width = 30;
	half_grid = grid_spacing / 2;

	difference() {
		union() {
			roundedbox( grid_spacing+leg_width, grid_spacing+leg_width, 4, locator_thick);
			// towers for drill guide
			translate([ half_grid, half_grid, locator_thick ]) cylinder( d=locator_tower_dia, h=locator_tower_height-locator_thick);
			translate([ -half_grid, half_grid, locator_thick ]) cylinder( d=locator_tower_dia, h=locator_tower_height-locator_thick);
		}

		translate([ 0, 0, -0.1 ]) roundedbox( grid_spacing-(leg_width/2), grid_spacing-(leg_width/2), 4, locator_thick+0.2);
		
		// holes for inserting (and gluing) locator pegs
		translate([ half_grid, -half_grid, -0.1]) cylinder( d=locator_peg_insert_hole_dia, h=locator_thick+0.2);
		translate([ -half_grid, -half_grid, -0.1 ]) cylinder( d=locator_peg_insert_hole_dia,  h=locator_thick+0.2);

		// drill bit holes inside towers
		translate([ half_grid, half_grid, -0.1 ]) cylinder( d=drill_diameter, h=locator_tower_height+0.2);
		translate([ -half_grid, half_grid, -0.1 ]) cylinder( d=drill_diameter, h=locator_tower_height+0.2);
	}

}

module locator_peg_insert() {
	cylinder( d=locator_tower_dia, h=2 );
	translate([ 0, 0, 2 ]) cylinder( d=locator_pin_dia, h=locator_thick+4 );
}


/*
 * the starter template has 4 holes and an edge guide, instead of 2 pegs and 2 holes
 * it is used to mark the first 4 holes in a new maze layout (the edge guide helps
 * to keep it parallel to the board edges)
 */
module drill_template_starter( dist_from_edgeX=25, dist_from_edgeY=25 ) {
	center_punch_dia = 2.5;
	grid_spacing = 180;
	leg_width = 15;
	guide_thick = 8;

	half_grid = grid_spacing / 2;
	offset_x = (dist_from_edgeX / 2) ;
	offset_y = (dist_from_edgeY / 2) ;

	difference() {
		translate([ offset_x, offset_y, 0 ]) 
			roundedbox( grid_spacing+leg_width+dist_from_edgeX, grid_spacing+leg_width+dist_from_edgeY, 4, locator_thick);

		translate([ 0, 0, -0.1 ]) 
			roundedbox( grid_spacing-(leg_width), grid_spacing-(leg_width), 4, locator_thick+0.2);

		translate([ half_grid, half_grid, -0.1 ]) 
			cylinder( d=center_punch_dia, h=locator_thick+0.2);
		translate([ -half_grid, half_grid, -0.1 ]) 
			cylinder( d=center_punch_dia, h=locator_thick+0.2);
		translate([ half_grid, -half_grid, -0.1 ]) 
			cylinder( d=center_punch_dia, h=locator_thick+0.2);
		translate([ -half_grid, -half_grid, -0.1 ]) 
			cylinder( d=center_punch_dia, h=locator_thick+0.2);
	}

	if (dist_from_edgeX > 0) {
		translate([ half_grid + (dist_from_edgeX), -(grid_spacing/2), locator_thick ]) cube([ 3, grid_spacing, guide_thick]);
	}

	if (dist_from_edgeY > 0) {
		translate([ -(grid_spacing/2), half_grid + (dist_from_edgeY),  locator_thick ]) cube([ grid_spacing, 3, guide_thick]);
	}
}


/*
 * the starter template has 4 holes and an edge guide, instead of 2 pegs and 2 holes
 * it is used to mark the first 4 holes in a new maze layout (the edge guide helps
 * to keep it parallel to the board edges)
 */
module drill_template_starter_with_guide( dist_from_edgeX=25, dist_from_edgeY=25 ) {
	center_punch_dia = 2.5;
	grid_spacing = 180;
	leg_width = 15;
	guide_thick = 8;
	plate_thick = 8;	// must be pretty thick because the guide itself is the "tower"

	half_grid = grid_spacing / 2;
	offset_x = (dist_from_edgeX / 2) ;
	offset_y = (dist_from_edgeY / 2) ;

	difference() {
		union() {
			translate([ offset_x, offset_y, 0 ]) 
			roundedbox( grid_spacing+leg_width+dist_from_edgeX, grid_spacing+leg_width+dist_from_edgeY, 4, plate_thick);
		}

		translate([ 0, 0, -0.1 ]) 
			roundedbox( grid_spacing-(leg_width), grid_spacing-(leg_width), 4, plate_thick+0.2);

		translate([ half_grid, half_grid, -0.1 ]) 
			cylinder( d=locator_pin_dia, h=plate_thick+0.2);
		translate([ -half_grid, half_grid, -0.1 ]) 
			cylinder( d=locator_pin_dia, h=plate_thick+0.2);
		translate([ half_grid, -half_grid, -0.1 ]) 
			cylinder( d=locator_pin_dia, h=plate_thick+0.2);
		translate([ -half_grid, -half_grid, -0.1 ]) 
			cylinder( d=locator_pin_dia, h=plate_thick+0.2);
	}

	if (dist_from_edgeX > 0) {
		translate([ half_grid + (dist_from_edgeX), -(grid_spacing/2), plate_thick ]) cube([ 3, grid_spacing, guide_thick]);
	}

	if (dist_from_edgeY > 0) {
		translate([ -(grid_spacing/2), half_grid + (dist_from_edgeY),  plate_thick ]) cube([ grid_spacing, 3, guide_thick]);
	}
}

module drill_sizer() {
	difference() {
		roundedbox( 70, 25, 3, 2);
		translate([ -26, 0, -0.1 ]) cylinder( d=9.5, h=2.2 );
		translate([ -13, 0, -0.1 ]) cylinder( d=9.7, h=2.2 );
		translate([ 0, 0, -0.1 ]) cylinder( d=9.9, h=2.2 );
		translate([ 13, 0, -0.1 ]) cylinder( d=10.1, h=2.2 );
		translate([ 26, 0, -0.1 ]) cylinder( d=10.3, h=2.2 );
	}
}