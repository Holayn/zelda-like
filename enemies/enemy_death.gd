extends Node2D

func _ready():
	$anim.connect("animation_finished", self, "destroy")
	$anim.play("default")

func destroy(animation):
	queue_free()
