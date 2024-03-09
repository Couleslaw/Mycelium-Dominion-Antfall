extends Node2D

var score_label
const SCORE_NEEDED = 20
var score = 0

var hp_label
const MAX_HEALTH = 5
var health = MAX_HEALTH

func _ready():
	score_label = $ScoreLabel
	hp_label = $PlayerHealthLabel
	update_score_label()
	update_hp_label()
	
func update_score_label():
	score_label.text = str(score) + "/" + str(SCORE_NEEDED)
	
func update_hp_label():
	hp_label.text = str(health) + "/" + str(MAX_HEALTH)

func _on_enemy_died():
	score += 1
	update_score_label()
	
	if score == SCORE_NEEDED:
		pass
		# despawn all lady bugs 
		# make boss appear

func _on_enemy_spawner_spawned_enemy(enemy):
	enemy.connect("enemy_died", _on_enemy_died)

func _on_player_player_hit():
	health -= 1
	update_hp_label()
	
	if health == 0:
		# play death animation
		$Player.hide()
	
