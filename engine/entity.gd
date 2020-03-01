extends KinematicBody2D

const MAX_HEALTH = 2
var movedir = Vector2(0,0)
var knockdir = Vector2(0,0)
var spritedir = "up"

var TYPE = "DEFAULT"
var SPEED = 0
var DAMAGE = 0

var hitstun = 0
var health = MAX_HEALTH

var texture_default = null
var texture_hurt = null

func _ready():
	texture_default = $Sprite.texture
	texture_hurt = load($Sprite.texture.get_path().replace('.png', '_hurt.png'))
	if TYPE == "ENEMY":
		set_physics_process(false)

func movement_loop(SPEED):
	var motion
	if hitstun == 0:
		motion = movedir.normalized() * SPEED
	else:
		motion = knockdir.normalized() * 125
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
		$Sprite.texture = texture_hurt
	else:
		$Sprite.texture = texture_default
		if health <= 0:
			var death_animation = preload("res://enemies/enemy_death.tscn").instance()
			death_animation.global_transform = global_transform
			get_parent().add_child(death_animation)
			queue_free()
			return
	for a in $hitbox.get_overlapping_areas():
		var body = a.get_parent()
		
		if hitstun == 0 and body.get("DAMAGE") != null and body.get("DAMAGE") != 0 and body.get("TYPE") != TYPE:
			health -= body.get("DAMAGE")
			
			hitstun = 10
			knockdir = global_transform.origin - body.global_transform.origin

func use_item(item):
	var instance = item.instance()
	instance.add_to_group(str(instance, self))
	add_child(instance)
	if get_tree().get_nodes_in_group(str(instance, self)).size() > instance.maxamount:
		instance.queue_free()
