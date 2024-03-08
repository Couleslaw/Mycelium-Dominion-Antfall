extends Area2D

var speed = 350
var screen_size
signal player_shoot

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
func shoot_bullet():
	player_shoot.emit()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		velocity = Vector2.LEFT
	if Input.is_action_pressed("move_right"):
		velocity = Vector2.RIGHT
	position += velocity * speed * delta
	
	var margin = screen_size / 8
	position = position.clamp(margin, screen_size-margin)
	
	if Input.is_action_just_pressed("shoot"):
		shoot_bullet()
