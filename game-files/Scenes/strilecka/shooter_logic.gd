extends Node2D

@export var bullet_scene : PackedScene

var player_bullet_speed = 1000
var enemy_bullet_speed = 1000

func _on_player_shoot():
	var bullet = bullet_scene.instantiate() 
	bullet.position = $Player.position
	bullet.linear_velocity = Vector2.UP * player_bullet_speed
	add_child(bullet)
	print("jo")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
