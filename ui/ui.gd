extends CanvasLayer

func _process(delta):
	var player = get_node("../player")
	if player:
		$keys.frame = get_node("../player").keys
