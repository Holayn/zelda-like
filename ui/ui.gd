extends CanvasLayer

onready var player = get_node("../player")

const HEALTH_ROW_LENGTH = 8
const HEART_SPACING = 8
const HFRAMES = 5

func _ready():
	for i in player.health:
		var new_heart = Sprite.new()
		new_heart.texture = load("res://ui/hearts.png")
		new_heart.hframes = HFRAMES
		new_heart.frame = 4
		$hearts.add_child((new_heart))
	for heart in $hearts.get_children():
		var index = heart.get_index()
		
		var x = (index % HEALTH_ROW_LENGTH) * HEART_SPACING
		var y = (index / HEALTH_ROW_LENGTH) * HEART_SPACING
		heart.position = Vector2(x,y)

func _process(delta):
	if is_instance_valid(player):
		$keys.frame = player.keys
	
		var curr_health = player.health
		var difference = curr_health - floor(curr_health)
		var index = floor(curr_health)
		if (index == $hearts.get_children().size()):
			return
		
		$hearts.get_child(index).frame = int(difference * 4)
