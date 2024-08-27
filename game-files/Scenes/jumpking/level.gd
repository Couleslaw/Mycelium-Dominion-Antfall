extends StaticBody2D

var GET_HINT = 2
var hint_count = 0


func _on_hint_body_entered(body):
	if body.name == "Player":
		hint_count+=1
		if hint_count >= GET_HINT:
			$MinigameJumpMushroom/DownArrow.show()

func antbite():
	var snail = $MinigameJumpMushroom/SlugGlowing 
	snail.modulate.a = 0
	snail.show()
	for i in range(100):
		snail.modulate.a += 0.01
		await get_tree().create_timer(0.01).timeout
	
	snail.modulate.a = 1
	
