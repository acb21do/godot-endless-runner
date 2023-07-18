extends ParallaxBackground


func _process(delta):
	scroll_offset.x -= Global.tile_size * delta
