extends Node

var viewport_width
var tile_size = 64

func _ready():
	viewport_width = get_viewport().get_visible_rect().size.x
	process_mode = Node.PROCESS_MODE_DISABLED
