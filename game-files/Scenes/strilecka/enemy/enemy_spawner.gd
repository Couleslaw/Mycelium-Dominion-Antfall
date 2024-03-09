extends Node2D


@export var enemy_scene: PackedScene

var left_spawner
var right_spawner
var spawn_timer

var MIN_SPAWN_INTERVAL = 3
var MAX_SPAWN_INTERVAL = 7

func set_new_spawn_interval():
	spawn_timer.wait_time = randf_range(MIN_SPAWN_INTERVAL, MAX_SPAWN_INTERVAL)

# Called when the node enters the scene tree for the first time.
func _ready():
	left_spawner = get_node("LeftSpawn")
	right_spawner = get_node("RightSpawn")
	spawn_timer = get_node("SpawnTimer")

func _on_spawn_timer_timeout():
	var spawner = [left_spawner, right_spawner][randi_range(0,1)]
	var enemy = enemy_scene.instantiate()
	enemy.position = spawner.position
	enemy.position.y += randi_range(-20, 10)
	set_new_spawn_interval()
	add_child(enemy)	
