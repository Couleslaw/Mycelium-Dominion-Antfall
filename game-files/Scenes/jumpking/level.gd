extends StaticBody2D

var GET_HINT = 2
var hint_count = 0


func _on_hint_body_entered(body):
	if body.name == "Player":
		hint_count+=1
		if hint_count >= GET_HINT:
			$DownArrow.show()
