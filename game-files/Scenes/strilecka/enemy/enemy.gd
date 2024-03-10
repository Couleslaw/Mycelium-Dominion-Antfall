extends CharacterBody2D

signal enemy_died(enemy)

const MIN_SPEED = 150
const MAX_SPEED = 300

const MIN_CHANGE_DIR_TIME = 1
const MAX_CHANGE_DIR_TIME = 2

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

var speed = randi_range(MIN_SPEED, MAX_SPEED)
var direction = 1
var change_dir_timer
var shoot_timer

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	sprite = $AnimatedSprite2D
	
	shoot_timer = $ShootTimer
	shoot_timer.wait_time = randf_range(MIN_SHOOT_COOLDOWN, MAX_SHOOT_COOLDOWN)
	shoot_timer.start()

	change_dir_timer = $ChangeDirTimer	
	change_dir_timer.wait_time = randf_range(MIN_CHANGE_DIR_TIME, MAX_CHANGE_DIR_TIME)
	walk_toward_center()
	if position.x < 0 or position.x > screen_size.x:
		change_dir_timer.wait_time = randf_range(3, 7)
	change_dir_timer.start()
	
func walk_toward_center():
	if position.x < screen_size.x / 2:
		direction = 1
	else:
		direction = -1
	
func shoot_bullet():
	var bullet = enemy_bullet_scene.instantiate()
	bullet.global_position = position
	bullet.linear_velocity = Vector2.DOWN * 700
	get_parent().add_child(bullet)

func _process(delta):
	if position.y < -50: 
		queue_free()
	if flying_away:
		rotation += delta * FLY_AWAY_ROTATION_SPEED
		position += Vector2.UP * delta * FLY_AWAY_SPEED
	else:
		if position.x < 0 or position.x > screen_size.x:
			walk_toward_center()
		position += Vector2.RIGHT * delta * speed * direction 
		sprite.flip_h = direction < 0
		
	if not (playing_take_damage_animation):
		sprite.play("walk")

func _on_change_dir_timer_timeout():
	change_dir_timer.wait_time = 1#randf_range(MIN_CHANGE_DIR_TIME, MAX_CHANGE_DIR_TIME)
	if randf() < 0.5:
		direction *= -1

var flying_away = false

func freeze(duration):
	shoot_timer.stop()
	await get_tree().create_timer(duration).timeout
	shoot_timer.start()

func get_hit():
	$HitSound.play()
	health -= 1
	playing_take_damage_animation = true
	sprite.play("take_damage")
	$TakeDmgAnimationTimer.start(TAKE_DAMAGE_ANIMATION_DURATION)
	if health == 0:
		flying_away = true
		enemy_died.emit(self)
	return true

func _on_shoot_timer_timeout():
	if flying_away: return
	shoot_timer.wait_time = randf_range(MIN_SHOOT_COOLDOWN, MAX_SHOOT_COOLDOWN)
	shoot_bullet()


func _on_take_dmg_animation_timer_timeout():
	playing_take_damage_animation = false
