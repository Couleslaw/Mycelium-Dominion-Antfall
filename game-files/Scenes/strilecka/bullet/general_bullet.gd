extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision_info = move_and_collide(linear_velocity * delta)
	if collision_info != null:
		if collision_info.get_collider_velocity() != Vector2.ZERO:
			collision_info.get_collider().get_hit()
		queue_free()
		
func get_hit():
	pass 
