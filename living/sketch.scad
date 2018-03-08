mm = 0.1;
cm = 10 * mm;
in = 100 * cm / 39.37;
ft = 12 * in;

glass_opacity = 0.1;
shell_opacity = 1;
roof_opacity = 1;

length = 29 * ft;
width = 8 * ft;
end_thickness = 20 * cm;
rear_engine_thickness = 65*cm;
rear_engine_height = 2 * ft;
rear_high_offset = length - end_thickness;
rear_low_offset = rear_high_offset - rear_engine_thickness;
floor_height = 2 * ft;
subwall_height = 3 * ft;

step_count = 3;
step_offset = 20 * cm;
step_width = 66 * cm;
step_height = 15 * cm;
step_depth = 24 * cm;
stairs_depth = step_depth * step_count;

window_height = 20 * in;
window_width = 20 * in;
window_frame = 0.75 * in;
window_offset = step_width + step_offset + window_frame;

window_count = floor((length-window_offset)/window_width);
window_total_length = window_count * window_width;

door_offset = step_offset;
door_width = step_width;
door_bottom = floor_height - step_height*step_count;
door_height = step_height*step_count + subwall_height + window_height;
door_frame = 2 * in;

partition_offset = window_offset + window_width * 1.5;
partition_thickness = 64*mm;
partition_door_width = 50*cm;
partition_door_edge = -20*cm;

wall_insulation = 3*in;
wall_surface_thickness = 3/8*in;
wall_thickness = wall_insulation + wall_surface_thickness;

floor_offset = partition_offset + partition_thickness;
floor_length = rear_low_offset - floor_offset;
floor_width = width - 2*wall_thickness;
floor_insulation = 2*in;
floor_surface_thickness = 3/8*in;
surface_top = floor_height + floor_insulation + floor_surface_thickness;

module stair(depth, width, height, thickness){
	difference(){
		cube([depth, width, height]);
		translate([-thickness, thickness, thickness]) cube([depth, width-2*thickness, height]);
	}
}

module stairway(count, depth, width, height, thickness){
	// steps
	for(i = [0:count-1]){
		translate([i*depth, 0, i*height])
		stair(depth, width, height, thickness);
	}
	// right hand side
	rotate([90,0,0])
	linear_extrude(height=thickness){
		polygon(points=[[0,0],[count*depth, count*height],[0,count*height]]);
	}
	// left hand side
	translate([0,width,0])
	rotate([90,0,0])
	linear_extrude(height=thickness){
		polygon(points=[[0,0],[count*depth, count*height],[0,count*height]]);
	}
}

module pane(outer_width, outer_height, thickness, frame){
	width = outer_width - frame;
	height = outer_height - frame;
//	color("skyblue", glass_opacity)
		translate([thickness, frame/2, frame/2])
		cube([thickness, width, height]);
//	color("silver"){
		difference(){
			cube([3*thickness, width+frame, height+frame]);
			translate([-thickness, frame, frame])
		cube([5*thickness, width-frame, height-frame]);
		}
//	}
}
module window(outer_width, outer_height, thickness, frame){
	width = outer_width - frame/4;
	height = outer_height/2;
	translate([thickness, frame/2, 0]){
		pane(width, height, thickness, frame);
		translate([3*thickness, 0, height])
		pane(width, height, thickness, frame);
	}
//	color("silver"){
		difference(){
			cube([8*thickness, width+2*frame, 2*height]);
			translate([-thickness, frame/2, frame/2])
			cube([10*thickness, width+frame, 2*height-frame/2]);
			translate([thickness, frame/4, frame/4])
			cube([6*thickness, width+3*frame/2, 2*height-frame/4]);
		}
//	}
}

/*
module semiellipse(rx, ry){
	polygon([for(t=[0:180]) [rx*cos(t), -ry*sin(t)]]);
}
module roofshell(rx, ry, length, thickness){
	rotate([-90,0,0]){
		linear_extrude(height=length)
		difference(){
			semiellipse(rx,ry);
			semiellipse(rx-2*thickness, ry-thickness);
		}
		
		linear_extrude(height=thickness)
		semiellipse(rx,ry);
		
		translate([0,0,length-thickness])
		linear_extrude(height=thickness)
		semiellipse(rx,ry);		
	}
}
*/

union(){

// housing metal
//color("darkred", shell_opacity)
difference(){
	translate([-width/2-1*mm,-1*mm,floor_height-1*mm])
	cube([width+2*mm, length+2*mm, subwall_height + window_height + 1*mm]);
	// hollow interior
	translate([-width/2.0, 0, floor_height])
	cube([width, length, subwall_height + window_height+1*cm]);
	// stairwell
	translate([-width/2, step_offset, floor_height-1*cm])
	cube([stairs_depth,step_width,3*cm]);
	// door hole
	translate([-width/2-1*cm, door_offset, door_bottom])
	cube([3*cm, door_width, door_height]);
	// windows hole
	for(side=[-width/2,width/2])
	translate([side-1*cm, window_offset, floor_height+subwall_height])
	cube([3*cm, window_total_length, window_height]);
	// driver's side window
	translate([width/2-1*cm, step_offset/2, floor_height+subwall_height])
	cube([3*cm, step_width, window_height]);
	// nose windows
	translate([-width/2+1*mm,-1*cm,floor_height+subwall_height*0.75])
	cube([width-2*mm, 3*cm, window_height+subwall_height*0.25]);
}

/*
//color(undef, roof_opacity)
translate([0,0,floor_height+subwall_height+window_height])
roofshell(width/2, 30*cm, length, 1*mm);
*/

// steps
translate([-width/2.0, step_offset, door_bottom])
stairway(step_count, step_depth, step_width, step_height, 1*mm);

// windows!
for(side=[0, 1]){
	for(i=[0:window_count-1]){
		translate([(side-0.5)*(width+12*mm), window_offset + i*window_width, floor_height + subwall_height])
//		mirror([side,0,0])
		window(window_width, window_height, 2*mm, window_frame);
	}
}

// nose windows
translate([0,0,floor_height+subwall_height*0.75])
for(th=[-90,90]){
	rotate([0,0,th])
	pane(width/2, window_height+subwall_height*0.25, 2*mm, 0.5*in);
}

// driver's window
translate([width/2, step_offset/2, floor_height+subwall_height])
pane(step_width, window_height, 2*mm, 0.5*in);

// door
for(i=[0:1]){
	translate([-width/2, step_offset + i*step_width/2, door_bottom])
	pane(step_width/2, door_height, 2*mm, door_frame);
}

// engine block
//color("grey")
translate([-width/2, rear_low_offset, floor_height])
cube([width, rear_engine_thickness, rear_engine_height]);

// wall insulation
//color("cyan")
for(side=[0,1]){
translate([(side-0.5)*(width-2*side*wall_insulation), floor_offset, floor_height + floor_insulation])
cube([wall_insulation, floor_length + rear_engine_thickness, subwall_height - floor_insulation]);
}

// wall surface
//color("tan")
for(side=[0,1]){
translate([(side-0.5)*(width-2*wall_insulation-2*side*wall_surface_thickness), floor_offset, floor_height + floor_insulation])
cube([wall_surface_thickness, floor_length + rear_engine_thickness, subwall_height - floor_insulation]);
}

// floor insulation
//color("cyan")
translate([-width/2, floor_offset, floor_height])
cube([width, floor_length, floor_insulation]);

// floor surface
//color("tan")
translate([-floor_width/2, floor_offset, floor_height + floor_insulation])
cube([floor_width, floor_length, floor_surface_thickness]);

}
