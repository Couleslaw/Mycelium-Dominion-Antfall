extends Node2D

@export var bullet_scene : PackedScene
var wait = false

func set_camera_limits():
	$Player/Camera2D.limit_left = $Level/BorderLeft.position.x
	$Player/Camera2D.limit_right = $Level/BorderRight.position.x
	$Player/Camera2D.limit_top = $Level/BorderTop.position.y
	$Player/Camera2D.limit_bottom = $Level/BorderBottom.position.y
	

# Called when the node enters the scene tree for the first time.
func _ready():
	set_camera_limits()


func _on_area_2d_body_entered(body):
	$Player.stop()
	wait = true
	$Label.modulate.a = 0
	$Label.visible = true
	for i in range(50):
		$Label.modulate.a += 0.02
		await get_tree().create_timer(0.01).timeout
	
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE and wait:
			var bullet = bullet_scene.instantiate()
			bullet.linear_velocity = Vector2.RIGHT * 600
			bullet.position = $Player.position + $Player/Marker2D.position
			bullet.get_node("Sprite2D").scale = Vector2(0.05,0.05)
			add_child(bullet)
			bullet.get_node("PointLight2D").energy = 1
			
			if $Label.visible:
				for i in range(50):
					$Label.modulate.a -= 0.02
					await get_tree().create_timer(0.01).timeout
				$Label.visible = false
			
func finish():
	if not Global.platformer_won: 
		Global.increase_mushroom_level()
		Global.platformer_won = true
	get_tree().change_scene_to_file("res://Scenes/mainmenu/levelmap.tscn")
	
