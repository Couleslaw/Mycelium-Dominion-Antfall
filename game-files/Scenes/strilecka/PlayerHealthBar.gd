extends TextureProgressBar

@export var game_logic: Node2D

func update():
	value = 100 * game_logic.player_health / game_logic.PLAYER_MAX_HEALTH
	
func _ready():
	update()

