extends Camera2D

var shake_strength = 0
var shake_fade = 5
var stop_shake = false

@onready var start_offset = offset

func apply_camera_shake(duration):
	shake_strength = 30
	stop_shake = false
	await get_tree().create_timer(duration).timeout
	stop_shake = true

func random_offset():
	return Vector2(randf_range(-shake_strength, shake_strength), randf_range(-shake_strength, shake_strength))

func _process(delta):
	if shake_strength > 0:
		offset = start_offset + random_offset()
		if stop_shake:		
			shake_strength = lerpf(shake_strength, 0, shake_fade*delta)
