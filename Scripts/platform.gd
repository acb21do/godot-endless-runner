extends TileMap

signal spawn_tile

var width : int = 15
var height : int = 3
var tile_width : int = Global.tile_size
var tile_per_sec = 5
var tile_spawned = false

func _ready():
	pass


func create_platform(width : int = self.width, height : int = self.height, platform_type : int = 0):
	#Creates an autotile platform
	var path : Array[Vector2i] = []
	for i in range(width):
		path.append(Vector2i(i, height))
	set_cells_terrain_connect(0, path, 0, platform_type)
	#Sets the width for calculating the platform end position
	self.width = width
	#Sets the Visibility node rect to cover the whole platform
	$VisibleOnScreenNotifier2D.position = Vector2(0, height * tile_width)
	$VisibleOnScreenNotifier2D.rect.size = Vector2(width * tile_width, tile_width)
	

func _process(delta):
	#Moves the platform
	var speed = tile_width * tile_per_sec 
	position.x -= speed * delta
	#Checks if the end of the platform is onscreen and emits a signal to spawn a new one
	var platform_end_pos_x = global_position.x + (width * tile_width)
	if platform_end_pos_x < Global.viewport_width and not tile_spawned:
		emit_signal("spawn_tile")
		tile_spawned = true


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
