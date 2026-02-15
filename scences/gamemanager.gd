extends Node

@onready var gamemanager: Node = %gamemanager
@onready var scorelabel: Label = $scorelabel

var score = 0

func add_point():
	score += 1
	scorelabel.text ="你获得了 " + str(score) + " 金币 "
