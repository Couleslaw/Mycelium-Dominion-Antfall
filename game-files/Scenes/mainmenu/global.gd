extends Node

var mushroom_level = 0
const MAX_LEVEL = 3
var maze_won = false
var platformer_won = false
var shooter_won = false

func increase_mushroom_level():
	mushroom_level = min(MAX_LEVEL, mushroom_level+1)
