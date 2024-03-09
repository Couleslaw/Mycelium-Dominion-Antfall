extends CharacterBody2D

var speed = 350
var screen_size
signal player_hit

var sprite
@export var player_bullet_scene : PackedScene
var player_bullet_speed = 1000

const TAKE_DAMAGE_ANIMATION_DURATION = 0.1
var playing_take_damage_animation = false

const SHOOT_ANIMATION_DURATION = 0.1
var playing_shoot_animation = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	sprite = $AnimatedSprite2D
	
func shoot_bullet():
	var bullet = player_bullet_scene.instantiate()
	var shift = $ShootMarker.position
	shift.x *= (-1 if sprite.flip_h else 1)
	bullet.global_position = position + shift
	bullet.linear_velocity = Vector2.UP * player_bullet_speed
	
	sprite.play("shoot")
	$ShootAnimationTimer.start(SHOOT_ANIMATION_DURATION)
	playing_shoot_animation = true
	
	get_parent().add_child(bullet)
	
var can_shoot = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dead: return
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		sprite.flip_h = true
		velocity = Vector2.LEFT
	if Input.is_action_pressed("move_right"):
		sprite.flip_h = false
		velocity = Vector2.RIGHT
	
	# play walk animation
	if not (playing_take_damage_animation or playing_shoot_animation):
		if velocity.length() > 0:
			sprite.play("walk")
		else:
			sprite.play("idle")
		
	position += velocity * speed * delta
	var margin = Vector2(screen_size.x/10, 0)
	position = position.clamp(margin, screen_size-margin)
	
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot_bullet()

func get_hit():
	sprite.play("take_damage")
	playing_take_damage_animation = true
	$TakeDmgAnimationTimer.start(TAKE_DAMAGE_ANIMATION_DURATION)
	player_hit.emit()

var dead = false

func die():
	$CollisionShape2D.set_deferred("disabled", true)
	can_shoot = false
	dead = true
	sprite.play("death")

func _on_take_dmg_animation_timer_timeout():
	playing_take_damage_animation = false


func _on_shoot_animation_timer_timeout():
	playing_shoot_animation = false
