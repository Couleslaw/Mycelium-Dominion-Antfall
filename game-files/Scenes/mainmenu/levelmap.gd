extends Control

@export var mushroom_sprites : Array[Resource]

func play_end_animation():
	pass
	
func return_to_main_scene():
	get_tree().change_scene_to_file("res://Scenes/mainmenu/mainmenu.tscn")

var mod = 1
const BOTTOM_TRS = 0.6
var rising_mod = false
var DELTA = 0.4
var sprites

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
	sprites = [$HlavniHouba, $LeftHouba, $CenterHouba, $RightHouba]
	
	if Global.mushroom_level == Global.MAX_LEVEL:
		play_end_animation()

func _process(delta):
	print(mod)
	if rising_mod:
		mod += DELTA*delta
		if mod > 1:
			mod = 1
			rising_mod = false
	else:
		mod -= DELTA*delta
		if mod < BOTTOM_TRS:
			mod = BOTTOM_TRS
			rising_mod = true
			
	for sprite in sprites:
		sprite.modulate.a = mod

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
