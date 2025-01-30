use <./tray.scad>

include <BOSL/constants.scad>
use <BOSL/masks.scad>

/*
  Parametric rack-mount tray:
  Dimensions can be adjusted using the variables below. You can also add mounting holes to fasten things that have
  screw holes at the bottom.

  !!! Please also make sure that the correct rack frame preset is set in rackFrame.scad !!!
*/

module traySystem (

// begin config ////////////////////////////////////////////////////////////////////////////////////////////////////////

// Height
trayU = 4,

// these dimensions are the total base width including padding not usable space. 
// e.g. 145 baseWidth and 3 sideThickness = 145-(3*2) = 139mm useable space.
baseWidth = 255,
baseDepth = 133,

baseThickness = 3, // tray bottom thickness
frontThickness = 3, // front plate thickness
sideThickness = 3,

backLipHeight = 2,
frontLipHeight = 2,

sideSupport = true,
trayLeftPadding = 0, // extra space between the left rail and tray. configure this to move the tray left/right.

mountPointType = "m3",
mountPointElevation = 1, // basically standoff height

// add/config standoff coordinates here. Format is [[x,y]]
mountPoints = [
    // mount 1 - from facing the rack
    [5+20,44],
    [5+20+49,44], 
    
    // Mount 2
    [255-10-30,3+24],
    [255-10-30-68,3+24],
    
    // add another mount?
]

// end config //////////////////////////////////////////////////////////////////////////////////////////////////////////

) {

  bottomScrewTray (
    u = trayU,
    trayWidth = baseWidth,
    trayDepth = baseDepth,
    trayThickness = baseThickness,
    frontLipHeight = frontLipHeight,
    backLipHeight = backLipHeight,
    mountPoints = mountPoints,
    frontThickness = frontThickness,
    sideThickness = sideThickness,
    mountPointElevation = mountPointElevation,
    mountPointType = mountPointType,
    sideSupport = sideSupport,
    trayLeftPadding = trayLeftPadding
  );
}

difference(){    
        traySystem();
        // How do I round the corners and put slits for airflow appropriately on the tray?
        //translate([10,10,-5]) cube([60, 5, 7]);

    for (x = [15:40:250]) {
            for (y = [10: 20: 100]) {
     // Generate slits with rounded edges
   hull() {
       translate([x,y,-1]) sphere(3);
        translate([x + 20,y,-1]) sphere(3);
   }
   #translate([10,10,-1]) right(80) chamfer_mask_y(l=80, chamfer=20);
   #up(50) #chamfer_cylinder_mask(r=50, chamfer=10); 
    }   
    }
}
