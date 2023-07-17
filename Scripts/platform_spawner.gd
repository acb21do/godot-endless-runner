extends Node

var platform_scene : PackedScene = preload("res://Scenes/platform.tscn")
var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var speed : int = 1
var speed_up_rate := 1
var width : int = 15
var height : int = 3
var platform_type : int = 0 # 0 for floor and 1 for air
var previous_height : int  = 3 # The height of the previous platform
var max_jump_gap = 512 + (64 * 5) #The largest gap that can be created


func speed_up():
	speed += speed_up_rate
	for platform in get_children():
		platform.tile_per_sec = speed


func _ready():
	rng.randomize()
	spawn_new_platform(0)


func spawn_new_platform(pos_x):
	#Creates and adds a new platform instance
	var platform := platform_scene.instantiate()
	platform.position.x = pos_x
	platform.create_platform(width, height, platform_type)
	platform.tile_per_sec = speed
	add_child(platform)
	#Randomly generate variables for the next platform
	width = rng.randi_range(1, 8)
	height = rng.randi_range(1, 3)
	var jump_gap = 512 + (64 * rng.randi_range(1, 5))
	#Changes the platform type depending on the height
	if height < 3:
		platform_type = 1
	else:
		platform_type = 0
	#Ensures there isn't a height gap greater than 1
	if(previous_height - height) > 1:
		height += 1
	#If the new platform is higher make the jump gap smaller
	if((previous_height - height) > 0 and jump_gap == max_jump_gap):
		jump_gap -= 64
	#Assign the previous height variable to the new height
	previous_height = height
	#Connects the current platform spawn_tile signal
	platform.spawn_tile.connect(spawn_new_platform.bind(jump_gap))


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		speed_up()
