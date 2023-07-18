extends Node

var platform_scene : PackedScene = preload("res://Scenes/platform.tscn")
var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var speed : int = 4
var speed_up_rate := 1
var platform_width : int = 15
var platform_height : int = 3 # Platform height refers the the tilemap placement, 0 top , 3 bottom of screen 
var min_platform_width : int = 1
var min_platform_height : int = 1
var max_platform_width : int = 5
var max_platform_height : int = 3
var min_jump_gap = 1
var max_jump_gap = 4
var platform_type : int = 0 # 0 for floor and 1 for air
var previous_height : int  = 3 # The platform_height of the previous platform

##Rapid jump phase


func speed_up():
	speed += speed_up_rate
	max_jump_gap = speed
	for platform in get_children():
		platform.tile_per_sec = speed


func _ready():
	rng.randomize()
	spawn_new_platform(0)


func spawn_new_platform(pos_x):
	#Creates and adds a new platform instance
	var platform : TileMap = platform_scene.instantiate()
	platform.position.x = pos_x
	platform.create_platform(platform_width, platform_height, platform_type)
	platform.tile_per_sec = speed
	add_child(platform)
	#Assigns the current height as the previous height
	previous_height = platform_height
	#Randomly generate new variables for the next platform
	platform_width = rng.randi_range(min_platform_width, max_platform_width)
	platform_height = rng.randi_range(min_platform_height, max_platform_height)
	var jump_gap_scalar = rng.randi_range(min_jump_gap, max_jump_gap)
	var jump_gap = (Global.viewport_width +
	(Global.tile_size * jump_gap_scalar))
	#Changes the platform type depending on the platform_height
	if platform_height < max_platform_height:
		#Generate an air platform
		platform_type = 1
	else:
		#Generate a floor platform
		platform_type = 0
	#Ensures there isn't a platform_height gap greater than 1
	if(previous_height - platform_height) > 1:
		platform_height += 1
	#If the new platform is higher make the jump gap smaller
	if((previous_height - platform_height) > 0 and jump_gap_scalar == max_jump_gap):
		jump_gap -= Global.tile_size
	
	#Connects the current platform spawn_tile signal
	platform.spawn_tile.connect(spawn_new_platform.bind(jump_gap))
