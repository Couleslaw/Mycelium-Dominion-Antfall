extends TextureProgressBar

@export var game_logic: Node2D

func update():
	value = 100 * game_logic.boss_health / game_logic.BOSS_MAX_HEALTH
	

func _ready():
	update()
	visible = false
