extends "res://engine/entity.gd"

var movetimer_length = 15
var movetimer = 0

func _init():
	TYPE = "ENEMY"
	SPEED = 40
	DAMAGE = 0.25

func _physics_process(delta):
	movement_loop(SPEED)
	damage_loop()
	
	if movetimer == 0:
		movetimer = movetimer_length
		movedir = dir.rand()
	else:
		movetimer -= 1

func _ready():
	$anim.play("default")
