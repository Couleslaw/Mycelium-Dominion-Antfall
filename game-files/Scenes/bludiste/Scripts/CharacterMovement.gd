extends CharacterBody2D

@export var tilemap_path : NodePath
@export var start_position_path : NodePath
var tilemap
var start_position

const BASE_ENERGY = 1.67
const SPEED = 600
const SPECIAL_TILE_POWER = 1000
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_dead = false

func _ready():
	#get_parent().get_node("AudioStreamPlayer").play()
	tilemap = get_node(tilemap_path)
	start_position = get_node(start_position_path)
	resurrect()

func velocity_to_rad(vel):
	return vel.angle() + PI / 2

func player_movement():

	velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	var new_rot = null
	if velocity != Vector2.ZERO:
		new_rot = velocity_to_rad(velocity)
		if new_rot != null:
			rotation = new_rot


func _physics_process(delta):
	
	if !is_dead:
		player_movement()

		animate()
	
		var dir = get_current_tile_dir()
		if dir != null:
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

func die():
	is_dead = true
	$DeathSound.play()
	$AnimatedSprite2D.stop()
	
	
func resurrect():
	$PointLight2D.energy = BASE_ENERGY
	position = start_position.position
	is_dead = false

# da ant is being killed
func _on_area_2d_body_entered(body):
	if !is_dead:
		die()
		for i in range(10):
			$PointLight2D.energy -= 1
			await get_tree().create_timer(0.1).timeout
		resurrect()
	
	
	
