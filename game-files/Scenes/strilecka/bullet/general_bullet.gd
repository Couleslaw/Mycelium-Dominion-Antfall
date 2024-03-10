extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(3).timeout
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision_info = move_and_collide(linear_velocity * delta)
	if collision_info != null:
		var name = collision_info.get_collider().name
		var should_despawn = collision_info.get_collider().get_hit()
		if should_despawn: queue_free()

func get_hit():
	return false 


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
