extends Area2D


func _on_body_entered(body):
	if body.name == "Player":
		$"../../../Camera2D".make_current()
		$"../../../AnimationPlayer".play("shroom_transition")
		await get_tree().create_timer(3.0).timeout
		get_tree().change_scene_to_file("res://Scenes/mainmenu/levelmap.tscn")
