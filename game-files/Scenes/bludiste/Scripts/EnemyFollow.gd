extends PathFollow2D

@export var speed = 400

func _process(delta):
	set_progress(get_progress() + speed * delta)
