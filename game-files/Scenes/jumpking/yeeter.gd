extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print(rotation_degrees)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		var dir = 1 if rotation_degrees > 89 and rotation_degrees < 91 else -1
		body.yeet(dir)
