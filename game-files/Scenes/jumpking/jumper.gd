extends Area2D


func _on_body_entered(body):
	if body.name == "Player":
		$SpringboardSound.play()
		body.catapult()
