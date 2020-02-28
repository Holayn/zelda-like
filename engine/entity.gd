extends KinematicBody2D

var movedir = Vector2(0,0)
var knockdir = Vector2(0,0)
var spritedir = "up"

var TYPE = "DEFAULT"

var hitstun = 0
var health = 1

func movement_loop(SPEED):
	var motion
	if hitstun == 0:
		motion = movedir.normalized() * SPEED
	else:
		motion = knockdir.normalized() * SPEED * 1.5
	move_and_slide(motion, Vector2(0,0))
	
func spritedir_loop():
	match movedir:
		Vector2(-1,0):
			spritedir = "left"
		Vector2(1,0):
			spritedir = "right"
		Vector2(0,1):
			spritedir = "down"
		Vector2(0,-1):
			spritedir = "up"

func anim_switch(animation):
	var new_anim = str(animation,spritedir)
	if $anim.current_animation != new_anim:
		$anim.play(new_anim)

func damage_loop():
	if hitstun > 0:
		hitstun -= 1;
	for body in $hitbox.get_overlapping_bodies():
		if hitstun == 0 and body.get("DAMAGE") != null and body.get("TYPE") != TYPE:
			health -= body.get("DAMAGE")
			hitstun = 10
			knockdir = transform.origin - body.transform.origin
