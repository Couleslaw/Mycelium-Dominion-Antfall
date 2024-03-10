extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const CATAPULT_VELOCITY = -1000
const CATAPULT_HIGH_LIMIT = 1000
const CATAPULT_HIGH_VELOCITY = -1650
const CATAPULT_LIMIT = 1000
const FLIGHT_SLOW_DOWN = 3.5
const FLIGHT_MOVEMENT_DENOMINATOR = 30
const FLIGHT_DIRECTION_LIMIT = 400
const YEET_VELOCITY = 1500
@onready var sprite = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		if direction < 0:
			sprite.set_flip_h(true)
		else:
			sprite.set_flip_h(false)
		
		if is_on_floor():
			velocity.x = direction * SPEED
		elif not (sign(velocity.x) == sign(direction) and abs(velocity.x) > FLIGHT_DIRECTION_LIMIT):
			velocity.x = move_toward(velocity.x, direction*SPEED, SPEED/FLIGHT_MOVEMENT_DENOMINATOR) 
			
		$AnimatedSprite2D.play("run")
	else:
		var slow_down = SPEED if is_on_floor() else FLIGHT_SLOW_DOWN
		
		velocity.x = move_toward(velocity.x, 0, slow_down)
		
		if velocity == Vector2.ZERO:
			$AnimatedSprite2D.play("idle")
		else:
			$AnimatedSprite2D.stop()


	move_and_slide()

func catapult():
	if velocity.y < CATAPULT_HIGH_LIMIT:
		velocity.y = CATAPULT_VELOCITY
	else:
		velocity.y = CATAPULT_HIGH_VELOCITY
	
func yeet(dir):
	velocity.x = YEET_VELOCITY * dir
