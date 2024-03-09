extends Node2D


@export var enemy_scene: PackedScene
@export var boss_scene: PackedScene

signal spawned_enemy(enemy)
signal spawned_boss(boss)

var spawn_timer
var screen_size

var enemy_list = []

const NUM_ENEMIES_ON_START = 5
const MIN_SPAWN_INTERVAL = 1
const MAX_SPAWN_INTERVAL = 3

const BOSS_SPAWN_INTERVAL = 4

var spawn_y
var spawning = true

func set_new_spawn_interval():
	if boss_spawned:
		spawn_timer.wait_time = BOSS_SPAWN_INTERVAL
	else:
		spawn_timer.wait_time = randf_range(MIN_SPAWN_INTERVAL, MAX_SPAWN_INTERVAL)

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_timer = get_node("SpawnTimer")
	screen_size = get_viewport_rect().size
	spawn_y = screen_size.y / 12
	spawn_enemies_on_start()
	set_new_spawn_interval()
	
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
	enemy.connect("enemy_died", _on_enemy_died)
	enemy_list.append(enemy)
	
func end_game(delay):
	spawn_timer.stop()
	for enemy in enemy_list:
		enemy.freeze(delay)
	await get_tree().create_timer(delay).timeout
	for enemy in enemy_list:
		if enemy != null: enemy.queue_free()
	
func freeze_enemies(duration):
	for enemy in enemy_list:
		enemy.freeze(duration)
	spawn_timer.stop()
	await get_tree().create_timer(duration).timeout
	spawn_timer.start()

var boss_spawned = false

func spawn_boss():
	boss_spawned = true
	var spawn_pos = screen_size / 2
	var boss = boss_scene.instantiate()
	boss.position = spawn_pos
	spawned_boss.emit(boss)
	add_child(boss)

func _on_enemy_died(enemy):
	enemy_list.erase(enemy)

func _on_spawn_timer_timeout():
	set_new_spawn_interval()
	if len(enemy_list) > 20: return
	
	var spawn_x = [-50, screen_size.x+50][randi_range(0,1)]
	var enemy = enemy_scene.instantiate()
	spawn_enemy(Vector2(spawn_x, spawn_y))

