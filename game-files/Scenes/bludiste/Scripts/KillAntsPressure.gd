extends Area2D

var playing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_node("KillEggsCanvas").visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_pressed("shoot"):
		if get_parent().get_node("KillEggsCanvas").visible:
			if !playing:
				playing = true
				$InfectionSound.play()


func _on_body_entered(body):
	get_parent().get_node("KillEggsCanvas").visible = true


func _on_body_exited(body):
	get_parent().get_node("KillEggsCanvas").visible = false
