extends Control

func _ready():
	$LeftLightBG.modulate.a = 0
	$RightLightBG.modulate.a = 0


func _on_end_shroom_pressed():
	get_tree().quit()

func _on_start_shroom_pressed():
	get_tree().change_scene_to_file("res://Scenes/mainmenu/levelmap.tscn")

var animation_playing = false
const DELTA = 0.02
func _on_start_shroom_mouse_entered():
	animation_playing = true
	$RightLightBG.show()
	while $RightLightBG.modulate.a <1-DELTA and animation_playing:
		$RightLightBG.modulate.a += DELTA
		await get_tree().create_timer(0.01).timeout


func _on_start_shroom_mouse_exited():
	animation_playing = false
	while $RightLightBG.modulate.a > DELTA and animation_playing == false:
		$RightLightBG.modulate.a -= DELTA
		await get_tree().create_timer(0.01).timeout


func _on_end_shroom_mouse_entered():
	animation_playing = true
	$LeftLightBG.show()
	while $LeftLightBG.modulate.a <1-DELTA and animation_playing:
		$LeftLightBG.modulate.a += DELTA
		await get_tree().create_timer(0.01).timeout


func _on_end_shroom_mouse_exited():
	animation_playing = false
	while $LeftLightBG.modulate.a > DELTA and animation_playing == false:
		$LeftLightBG.modulate.a -= DELTA
		await get_tree().create_timer(0.01).timeout

