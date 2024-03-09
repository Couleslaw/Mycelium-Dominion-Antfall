extends Sprite2D


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		var dir = 1 if rotation_degrees > 89 and rotation_degrees < 91 else -1
		body.yeet(dir)
