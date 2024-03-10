extends Node2D

var player
var background1
var background2
var screen_size
func _ready():
	player = get_parent().get_node("Player")
	background1 = $Background1
	background2 = $Background2
	screen_size = get_viewport_rect().size

const PARALAX_INTENSITY_BACK = 0.2
const PARALAX_INTENSITY_FRONT = 0.1

func _process(delta):
	background1.position.x = PARALAX_INTENSITY_FRONT* ( 0.5*screen_size.x -600 - player.position.x )
	background2.position.x = PARALAX_INTENSITY_BACK* ( 0.5*screen_size.x -600- player.position.x )
