extends Node2D


func set_camera_limits():
	var map_limits = $StaticBody2D/Border.position.x  # $TileMap.get_used_rect()
	$Player/Camera2D.limit_left = map_limits


# Called when the node enters the scene tree for the first time.
func _ready():
	set_camera_limits()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

