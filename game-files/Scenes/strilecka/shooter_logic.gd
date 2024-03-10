extends Node2D

var score_label
const SCORE_NEEDED = 15
var score = 0

var player_hp_label
const PLAYER_MAX_HEALTH = 5
var player_health = PLAYER_MAX_HEALTH

var boss_hp_label
const BOSS_MAX_HEALTH = 12
var boss_health = BOSS_MAX_HEALTH

func _ready():
	score_label = $Labels/ScoreLabel
	player_hp_label = $Labels/PlayerHealthLabel
	boss_hp_label = $Labels/BossHealthLabel
	
	update_score_label()
	update_player_hp_label()
	update_boss_hp_label()
	
func update_score_label():
	score_label.text = str(score) + "/" + str(SCORE_NEEDED)
	
func update_player_hp_label():
	player_hp_label.text = str(player_health) + "/" + str(PLAYER_MAX_HEALTH)

func update_boss_hp_label():
	boss_hp_label.text = str(boss_health) + "/" + str(BOSS_MAX_HEALTH)
	
func update_boss_health_bar():
	$CanvasLayer/BossHealthBar.update()
	
func update_player_health_bar():
	$CanvasLayer/PlayerHealthBar.update()
	
func _on_enemy_spawner_spawned_enemy(enemy):
	enemy.connect("enemy_died", _on_enemy_died)
	
const BOSS_EMERGE_TIME = 3

func spawn_boss():
	$EnemySpawner.freeze_enemies(BOSS_EMERGE_TIME)
	$Player.can_shoot = false
	await get_tree().create_timer(BOSS_EMERGE_TIME).timeout
	$Player.can_shoot = true
	$CanvasLayer/BossHealthBar.visible = true
	$EnemySpawner.spawn_boss()

func _on_enemy_died(enemy):
	score += 1
	update_score_label()
	if score == SCORE_NEEDED:
		spawn_boss()


func _on_player_player_hit():
	player_health = max(0, player_health - 1)
	update_player_health_bar()
	
	if player_health == 0:
		player_died()

func _on_player_hit_by_boss():
	for i in range(player_health):
		_on_player_player_hit()
		await get_tree().create_timer(0.1).timeout

func _on_enemy_spawner_spawned_boss(boss):
	boss.connect("boss_hit", _on_boss_hit)
	boss.connect("player_hit_by_boss", _on_player_hit_by_boss)
	boss.connect("boss_attacked", _on_boss_attack)

func _on_boss_attack(duration):
	$Camera2D.apply_camera_shake(duration)

func _on_boss_hit(boss):
	boss_health = max(0, boss_health - 1)
	update_boss_health_bar()

	if boss_health == 0:
		boss_died(boss)


const PLAYER_DEATH_ANIMATION_DURATION = 6
const BOSS_DEATH_ANIMATION_DURATION = 4
const TIME_MARGIN = 2

func boss_died(boss):
	boss.die()
	$Player/CollisionShape2D.set_deferred("disabled", true)
	$Player.can_shoot = false
	$EnemySpawner.end_game(BOSS_DEATH_ANIMATION_DURATION)
	await get_tree().create_timer(BOSS_DEATH_ANIMATION_DURATION+TIME_MARGIN).timeout
	get_tree().change_scene_to_file("res://Scenes/mainmenu/levelmap.tscn")

func player_died():
	$Player.die()
	$EnemySpawner.end_game(PLAYER_DEATH_ANIMATION_DURATION)
	await get_tree().create_timer(PLAYER_DEATH_ANIMATION_DURATION+TIME_MARGIN).timeout
	get_tree().change_scene_to_file("res://Scenes/mainmenu/levelmap.tscn")
