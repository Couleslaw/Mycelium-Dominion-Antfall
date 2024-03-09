extends StaticBody2D

signal boss_hit(boss)
signal player_hit_by_boss

const HEAD_SPEED = 30
const HEAD_MARGIN_X = 150
const HEAD_MARGIN_Y = 60

const MIN_CHARGE_TIME = 2
const MAX_CHARGE_TIME = 4

const MIN_IDLE_TIME = 4
const MAX_IDLE_TIME = 6

const MIN_ATTACK_TIME = 3
const MAX_ATTACK_TIME = 5

var sprite
var center_position

var head_dir_x = 1
var head_dir_y = 1

var dead = false
var vunerable = false

func hover_head(delta):
	if position.x < center_position.x - HEAD_MARGIN_X:
		head_dir_x = 1
	if position.x > center_position.x + HEAD_MARGIN_X:
		head_dir_x = -1
	if position.y < center_position.y - HEAD_MARGIN_Y:
		head_dir_y = 1
	if position.y > center_position.y + HEAD_MARGIN_Y:
		head_dir_y = -1
	
	position += HEAD_SPEED * Vector2(head_dir_x, head_dir_y) * delta

func _ready():
	sprite = $AnimatedSprite2D
	center_position = position
	sprite.play("idle")
	await get_tree().create_timer(3.0).timeout 
	boss_fight()

func _process(delta):
	hover_head(delta)
	
func boss_fight():
	while not dead:
		sprite.play("charge")
		vunerable = true
		await get_tree().create_timer(randf_range(MIN_CHARGE_TIME, MAX_CHARGE_TIME)).timeout
		vunerable = false 
		sprite.play("idle")
		var attack_duration = randf_range(MIN_ATTACK_TIME, MAX_ATTACK_TIME)
		if dead: break
		$Attack.enable_atack(attack_duration)
		await get_tree().create_timer(attack_duration).timeout 
		await get_tree().create_timer(randf_range(MIN_IDLE_TIME, MAX_IDLE_TIME)).timeout 

func end_game():
	$CollisionShape2D.set_deferred("disabled", true)
	$Attack.disable_attack()
	sprite.play("idle")
	sprite.stop()

func die():
	dead = true
	end_game()
	#TODO play win animation

func get_hit():
	if not vunerable: return
	boss_hit.emit(self)
	# TODO: play hit animation


func _on_attack_body_entered(body):
	if body.name == "Player":
		player_hit_by_boss.emit()
