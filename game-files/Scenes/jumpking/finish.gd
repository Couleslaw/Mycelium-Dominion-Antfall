extends StaticBody2D


func get_hit():
	$"../AnimationPlayer".play("shroom_transition")
	return true
