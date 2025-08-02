extends Node2D
class_name Intro

signal skip

var index = 0
var vnodes : Array[Node] = []
var ispressed : bool = false

func _ready():
	index = 0
	vnodes = [get_node("First"), get_node("Second"), get_node("Third"), get_node("Fourth"), get_node("Fifth")]
	for n in vnodes:
		n.hide()
	next()
	
func next():
	print(index)
	if (index - 1>= 0):
		vnodes[index-1].hide()
	if (index >= 0):
		vnodes[index].show()
	index += 1

#func _process(_delta: float) -> void:
	#if Input.is_anything_pressed():
	#	if ispressed == false:
	#		ispressed = true
	#		if (index < vnodes.size()):
	#			next()
	#		else:
	#			skip.emit()
	#S	ispressed = false


func _on_button_button_up() -> void:
	if (index < vnodes.size()):
		next()
	else:
		skip.emit()
