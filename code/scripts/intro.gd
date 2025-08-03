extends Node2D
class_name Intro

signal skip

var index = 0
var vnodes : Array[Node] = []

func _ready():
	index = 0
	vnodes = [get_node("First"), get_node("Second"), get_node("Third"), get_node("Fourth"), get_node("Fifth"), get_node("Sixth")]
	for n in vnodes:
		n.hide()
	next()
	
func next():
	if (index - 1>= 0):
		vnodes[index-1].hide()
	if (index >= 0):
		vnodes[index].show()
	index += 1

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("main_action"):
		if (index < vnodes.size()):
			next()
		else:
			skip.emit()


func _on_button_button_up() -> void:
	if (index < vnodes.size()):
		next()
	else:
		skip.emit()
