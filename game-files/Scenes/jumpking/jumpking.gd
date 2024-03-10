extends Node2D


func set_camera_limits():
	var map_limits_left = $StaticBody2D/BorderLeft.position.x
	var map_limits_right = $StaticBody2D/BorderRight.position.x
	var map_limits_top = $StaticBody2D/BorderTop.position.y
	var map_limits_bottom = $StaticBody2D/BorderBottom.position.y
	
	$Player/Camera2D.limit_left = map_limits_left
	$Player/Camera2D.limit_right = map_limits_right
	$Player/Camera2D.limit_top = map_limits_top
	$Player/Camera2D.limit_bottom = map_limits_bottom
	

# Called when the node enters the scene tree for the first time.
func _ready():
	set_camera_limits()
