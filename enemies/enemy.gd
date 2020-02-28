extends "res://engine/entity.gd"

const SPEED = 40
const DAMAGE = 1

var movetimer_length = 15
var movetimer = 0

func _init():
	TYPE = "ENEMY"

func _physics_process(delta):
	movement_loop(SPEED)
	
	if movetimer == 0:
		movetimer = movetimer_length
		movedir = dir.rand()
	else:
		movetimer -= 1

func _ready():
	$anim.play("default")
