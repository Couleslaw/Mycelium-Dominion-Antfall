extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0
@onready var sprite = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		if direction < 0:
			sprite.set_flip_h(true)
		else:
			sprite.set_flip_h(false)
		
		if is_on_floor():
			velocity.x = direction * SPEED
		elif not (sign(velocity.x) == sign(direction) and abs(velocity.x) > 400):
			velocity.x = move_toward(velocity.x, direction*SPEED, SPEED/30) 
			
		$AnimatedSprite2D.play("default")
	else:
		var slow_down = SPEED
		if not is_on_floor():
			slow_down = 3.5
		velocity.x = move_toward(velocity.x, 0, slow_down)
		$AnimatedSprite2D.stop()

	move_and_slide()

func catapult():
	if velocity.y < 1000:
		velocity.y = JUMP_VELOCITY*2
	else:
		velocity.y = -1650
	
func yeet(dir):
	velocity.x = 1500 * dir
