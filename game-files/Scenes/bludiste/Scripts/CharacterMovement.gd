extends CharacterBody2D

@export var tilemap_path : NodePath
@export var start_position_path : NodePath
var tilemap
var start_position

const SPEED = 600
const SPECIAL_TILE_POWER = 1000
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	tilemap = get_node(tilemap_path)
	start_position = get_node(start_position_path)
	position = start_position.position

func velocity_to_rad(vel):
	return vel.angle() + PI / 2
	#if vel == Vector2.RIGHT: return PI/2
	#if vel == Vector2.LEFT: return -PI/2
	#if vel == Vector2.UP: return 0
	#if vel == Vector2.DOWN: return PI
	

func _physics_process(delta):

	velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		
	var new_rot = null
	if velocity != Vector2.ZERO:
		new_rot = velocity_to_rad(velocity)
		if new_rot != null:
			rotation = new_rot


	animate()
	
	var dir = get_current_tile_dir()
	if dir != null:
		if velocity != Vector2.ZERO:
			new_rot = velocity_to_rad(dir)
		if new_rot != null:
			print(new_rot)
			rotation = new_rot
		velocity += dir * SPECIAL_TILE_POWER
	
	
	
	move_and_slide()

func animate():
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
func get_current_tile_dir():
	var tile_coords = tilemap.local_to_map(tilemap.to_local(global_position))
	var data = tilemap.get_cell_tile_data(2,tile_coords)
	if data != null:
		var direction = data.get_custom_data("direction")
		#print(direction)
		return direction
	else:
		return null

func _on_area_2d_body_entered(body):
	position = start_position.position
