extends CharacterBody2D

const min_speed = 20
const max_speed = 70

const min_change_dir_time = 3
const max_change_dir_time = 7

const min_shoot_cooldown = 1
const max_shoot_cooldown = 3

const FLY_AWAY_SPEED = 400
const FLY_AWAY_ROTATION_SPEED = 4*PI

var health = 1

@export var enemy_bullet_scene : PackedScene

var speed

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = randi_range(min_speed, max_speed)
	$ChangeDirTimer.wait_time = randf_range(min_change_dir_time, max_change_dir_time)

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
	$ChangeDirTimer.wait_time = randf_range(min_change_dir_time, max_change_dir_time)
	speed *= -1

var flying_away = false

func get_hit():
	health -= 1
	if health > 0: return
	flying_away = true 
		

func _on_shoot_timer_timeout():
	if flying_away: return
	$ShootTimer.wait_time = randf_range(min_shoot_cooldown, max_shoot_cooldown)
	shoot_bullet()
