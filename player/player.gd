extends "res://engine/entity.gd"

var STATE = "DEFAULT"

var keys = 0

func _init():
	TYPE = "PLAYER"
	SPEED = 70

func _physics_process(delta):
	match STATE:
		"DEFAULT":
			state_default()
		"SWING":
			state_swing()
	
	keys = min(keys, 9)

func state_swing():
	anim_switch("idle")
	damage_loop()
	movement_loop(SPEED)
	movedir = dir.center
	

func state_default():
	controls_loop()
	movement_loop(SPEED)
	spritedir_loop()
	damage_loop()
	
	if is_on_wall():
		if spritedir == "left"  and test_move(transform, dir.left):
			anim_switch("push")
		if spritedir == "right"  and test_move(transform, dir.right):
			anim_switch("push")
		if spritedir == "down"  and test_move(transform, dir.down):
			anim_switch("push")
		if spritedir == "up"  and test_move(transform, dir.up):
			anim_switch("push")
	elif movedir != Vector2(0,0):
		anim_switch("walk")
	else:
		anim_switch("idle")
		
	if Input.is_action_just_pressed("a"):
		use_item(preload("res://items/sword.tscn"))

func controls_loop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")

	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)
