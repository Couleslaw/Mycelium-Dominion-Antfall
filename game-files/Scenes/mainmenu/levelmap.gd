extends Control

@export var mushroom_sprites : Array[Resource]

func _ready():
	$CPUParticles2D.emitting = true
	$LevelSelectionMusic.play()
	$HlavniHouba.texture = mushroom_sprites[Global.mushroom_level]
	$LeftHouba.visible = Global.maze_won
	$BludisteButton.disabled = Global.maze_won
	$CenterHouba.visible = Global.platformer_won
	$SkakackaButton.disabled = Global.platformer_won
	$RightHouba.visible = Global.shooter_won
	$StrileckaButton.disabled = Global.shooter_won


func _on_bludiste_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/bludiste/Scenes/level_1.tscn")


func _on_skakacka_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/jumpking/jumpking.tscn")


func _on_strilecka_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/strilecka/strilecka.tscn")

func _on_bludiste_button_mouse_entered():
	$LeftHouba.visible = true

func _on_bludiste_button_mouse_exited():
	if not Global.maze_won: $LeftHouba.visible = false

func _on_skakacka_button_mouse_entered():
	$CenterHouba.visible = true

func _on_skakacka_button_mouse_exited():
	if not Global.platformer_won: $CenterHouba.visible = false

func _on_strilecka_button_mouse_entered():
	$RightHouba.visible = true

func _on_strilecka_button_mouse_exited():
	if not Global.shooter_won: $RightHouba.visible = false
