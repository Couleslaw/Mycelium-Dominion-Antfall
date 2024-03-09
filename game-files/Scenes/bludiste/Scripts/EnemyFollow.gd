extends PathFollow2D

@export var speed = 20

func _process(delta):
	set_progress(get_progress()+1)
