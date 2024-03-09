extends Node2D


@export var enemy_scene: PackedScene

signal spawned_enemy(enemy)

var left_spawner
var right_spawner
var spawn_timer
var screen_size

const NUM_ENEMIES_ON_START = 5
const MIN_SPAWN_INTERVAL = 1
const MAX_SPAWN_INTERVAL = 3

var spawn_y

func set_new_spawn_interval():
	spawn_timer.wait_time = randf_range(MIN_SPAWN_INTERVAL, MAX_SPAWN_INTERVAL)

# Called when the node enters the scene tree for the first time.
func _ready():
	left_spawner = get_node("LeftSpawn")
	right_spawner = get_node("RightSpawn")
	spawn_timer = get_node("SpawnTimer")
	screen_size = get_viewport_rect().size
	spawn_y = screen_size.y / 11.3
	spawn_enemies_on_start()
	
func spawn_enemies_on_start():
	var margin = screen_size.x / (NUM_ENEMIES_ON_START + 1)
	for i in range(1, NUM_ENEMIES_ON_START + 1):
		spawn_enemy(Vector2(i*margin, spawn_y))
	
const MIN_SCALE = 0.7
const MAX_SCALE = 1.3
const DY_RATIO = 40

func spawn_enemy(pos):
	var enemy = enemy_scene.instantiate()
	enemy.position = pos
	var sc = randf_range(MIN_SCALE, MAX_SCALE)
	enemy.scale = Vector2(sc, sc) 
	var dy = DY_RATIO * sc - DY_RATIO
	enemy.position.y += dy
	spawned_enemy.emit(enemy)
	add_child(enemy)
	
func _on_spawn_timer_timeout():
	var spawn_x = [-50, screen_size.x+50][randi_range(0,1)]
	var enemy = enemy_scene.instantiate()
	spawn_enemy(Vector2(spawn_x, spawn_y))
	set_new_spawn_interval()
	
