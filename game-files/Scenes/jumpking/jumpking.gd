extends Node2D

@export var bullet_scene : PackedScene
var wait = false

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


func _on_area_2d_body_entered(body):
	$Player.stop()
	wait = true
	
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE and wait:
			var bullet = bullet_scene.instantiate()
			bullet.linear_velocity = Vector2.RIGHT * 600
			bullet.position = $Player.position + $Player/Marker2D.position
			bullet.get_node("Sprite2D").scale = Vector2(0.05,0.05)
			add_child(bullet)
			bullet.get_node("PointLight2D").energy = 1
			
func finish():
	if not Global.platformer_won: 
		Global.increase_mushroom_level()
		Global.platformer_won = true
	get_tree().change_scene_to_file("res://Scenes/mainmenu/levelmap.tscn")
	
