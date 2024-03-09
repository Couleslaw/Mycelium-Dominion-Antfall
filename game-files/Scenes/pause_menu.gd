extends Control

func _ready():
	hide()
	
#func _input(event : InputEvent):
	#if (event.is_action_pressed("ui_cancel")):
		#show()
		#var current_value = get_tree().paused
		#get_tree().paused = !current_value

func _on_back_to_shroom_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/mainmenu/levelmap.tscn")
	
func _on_continue_pressed():
	get_tree().paused = false
	hide()
