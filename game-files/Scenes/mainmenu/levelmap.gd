extends Control

func _on_bludiste_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/bludiste/Scenes/level_1.tscn")


func _on_skakacka_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/jumpking/jumpking.tscn")


func _on_strilecka_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/strilecka/strilecka.tscn")
