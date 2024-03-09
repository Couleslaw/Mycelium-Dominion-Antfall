extends CharacterBody2D

const MIN_SPEED = 50
const MAX_SPEED = 200

const MIN_CHANGE_DIR_TIME = 2
const MAX_CHANGE_DIR_TIME = 6

const MIN_SHOOT_COOLDOWN = 1
const MAX_SHOOT_COOLDOWN = 3

const FLY_AWAY_SPEED = 400
const FLY_AWAY_ROTATION_SPEED = 4*PI

var health = 1
var screen_size

@export var enemy_bullet_scene : PackedScene

var speed
var change_dir_timer

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = randi_range(MIN_SPEED, MAX_SPEED)
	screen_size = get_viewport_rect().size
	if position.x > screen_size.x / 2:
		speed *= -1
	change_dir_timer = $ChangeDirTimer
	change_dir_timer.wait_time = randf_range(4, 9)
	change_dir_timer.start()
	
func shoot_bullet():
	var bullet = enemy_bullet_scene.instantiate()
	bullet.global_position = position
	bullet.linear_velocity = Vector2.DOWN * 700
	get_parent().add_child(bullet)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.y < -50: 
		queue_free()
	if not flying_away:
		position += Vector2.RIGHT * delta * speed 
	else:
		rotation += delta * FLY_AWAY_ROTATION_SPEED
		position += Vector2.UP * delta * FLY_AWAY_SPEED 


func _on_change_dir_timer_timeout():
	change_dir_timer.wait_time = randf_range(MIN_CHANGE_DIR_TIME, MAX_CHANGE_DIR_TIME)
	speed *= -1

var flying_away = false

func get_hit():
	health -= 1
	if health > 0: return
	flying_away = true 
		

func _on_shoot_timer_timeout():
	if flying_away: return
	$ShootTimer.wait_time = randf_range(MIN_SHOOT_COOLDOWN, MAX_SHOOT_COOLDOWN)
	shoot_bullet()
