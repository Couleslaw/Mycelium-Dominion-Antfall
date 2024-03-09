extends Control


#func _ready():
	#$AudioStreamPlayer2D

func _on_end_shroom_pressed():
	get_tree().quit()

func _on_start_shroom_pressed():
	get_tree().change_scene_to_file("res://Scenes/mainmenu/levelmap.tscn")
