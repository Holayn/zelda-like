extends Node2D

var TYPE = null
const DAMAGE = 1

var maxamount = 1

func _ready():
	TYPE = get_parent().TYPE
	$anim.connect("animation_finished", self, "destroy")
	$anim.play(str(get_parent().spritedir))
	if get_parent().has_method("state_swing"):
		get_parent().STATE = "SWING"
	
func destroy(animation):
	if get_parent().has_method("state_default"):
		get_parent().STATE = "DEFAULT"
	queue_free()
	
