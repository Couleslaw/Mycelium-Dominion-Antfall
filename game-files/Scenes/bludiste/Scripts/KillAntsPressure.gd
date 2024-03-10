extends Area2D

var playing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_node("KillEggsCanvas").visible = false
	$InfectedEggs.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_pressed("interact"):
		if get_parent().get_node("KillEggsCanvas").visible:
			if !playing:
				playing = true
				get_parent().get_node("KillEggsCanvas").visible = false
				$InfectionSound.play()
				$InfectedEggs.visible = true
				$InfectedEggs.modulate.a = 0
				await get_tree().create_timer(0.2).timeout
				for i in range(5):
					$InfectedEggs.modulate.a += 0.2
					await get_tree().create_timer(1).timeout
				await get_tree().create_timer(1).timeout
				if not Global.maze_won:
					Global.maze_won = true
					Global.increase_mushroom_level()
				get_tree().change_scene_to_file("res://Scenes/mainmenu/levelmap.tscn")

func _on_body_entered(body):
	get_parent().get_node("KillEggsCanvas").visible = true


func _on_body_exited(body):
	get_parent().get_node("KillEggsCanvas").visible = false
