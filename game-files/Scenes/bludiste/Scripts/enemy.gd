extends CharacterBody2D

#func ready():
	#
func _physics_process(delta):
	$AnimatedSprite2D.play()
