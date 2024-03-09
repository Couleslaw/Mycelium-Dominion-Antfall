extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision_info = move_and_collide(linear_velocity * delta)
	if collision_info != null:
		print(collision_info.get_collider().name)
		if collision_info.get_collider().name == "Player":
			collision_info.get_collider().get_hit()
		if collision_info.get_collider().name.substr(0,5) == "Enemy":
			collision_info.get_collider().get_hit()
		queue_free()
