extends Node2D

@export var player_bullet_scene : PackedScene

var player_bullet_speed = 1000

func _on_player_shoot():
	var bullet = player_bullet_scene.instantiate() 
	bullet.position = $Player.position
	bullet.linear_velocity = Vector2.UP * player_bullet_speed
	add_child(bullet)

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass 
