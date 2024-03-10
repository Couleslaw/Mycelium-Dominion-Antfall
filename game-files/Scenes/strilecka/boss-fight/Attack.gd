extends Area2D


func enable_atack(duration):
	$AnimatedSprite2D.visible = true
	$CollisionShape2D.set_deferred("disabled", false)
	await get_tree().create_timer(duration).timeout 
	disable_attack()
	
func disable_attack():
	$AnimatedSprite2D.visible = false
	$CollisionShape2D.set_deferred("disabled", true)

# Called when the node enters the scene tree for the first time.
func _ready():
	disable_attack()

