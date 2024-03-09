extends CharacterBody2D

signal enemy_died

const MIN_SPEED = 150
const MAX_SPEED = 300

const MIN_CHANGE_DIR_TIME = 2
const MAX_CHANGE_DIR_TIME = 3

const MIN_SHOOT_COOLDOWN = 1
const MAX_SHOOT_COOLDOWN = 3

const FLY_AWAY_SPEED = 400
const FLY_AWAY_ROTATION_SPEED = 4*PI

const TAKE_DAMAGE_ANIMATION_DURATION = 0.1
var playing_take_damage_animation = false

var health = 1
var screen_size

@export var enemy_bullet_scene : PackedScene
var sprite

var speed
var change_dir_timer

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = randi_range(MIN_SPEED, MAX_SPEED)
	screen_size = get_viewport_rect().size
	sprite = $AnimatedSprite2D
	change_dir_timer = $ChangeDirTimer
	change_dir_timer.wait_time = randf_range(MIN_CHANGE_DIR_TIME, MAX_CHANGE_DIR_TIME)
	walk_toward_center()
	if position.x < 0 or position.x > screen_size.x:
		change_dir_timer.wait_time = randf_range(6, 11)
	change_dir_timer.start()
	
func walk_toward_center():
	if position.x > screen_size.x / 2:
		speed = - abs(speed)
	else:
		speed = abs(speed)
	
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
		sprite.flip_h = speed < 0
	else:
		rotation += delta * FLY_AWAY_ROTATION_SPEED
		position += Vector2.UP * delta * FLY_AWAY_SPEED 
		
	if not (playing_take_damage_animation):
		sprite.play("walk")

func _on_change_dir_timer_timeout():
	change_dir_timer.wait_time = randf_range(MIN_CHANGE_DIR_TIME, MAX_CHANGE_DIR_TIME)
	if randf() < 0.5:
		speed *= -1

var flying_away = false

func get_hit():
	health -= 1
	playing_take_damage_animation = true
	sprite.play("take_damage")
	$TakeDmgAnimationTimer.start(TAKE_DAMAGE_ANIMATION_DURATION)
	if health == 0:
		flying_away = true
		enemy_died.emit()
		

func _on_shoot_timer_timeout():
	if flying_away: return
	$ShootTimer.wait_time = randf_range(MIN_SHOOT_COOLDOWN, MAX_SHOOT_COOLDOWN)
	shoot_bullet()


func _on_take_dmg_animation_timer_timeout():
	playing_take_damage_animation = false
