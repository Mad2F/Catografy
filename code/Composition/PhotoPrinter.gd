extends Node

@export var yMin : float = 0
@export var yMax : float = 0.75
@export var scaleClose : float = 1.
@export var scaleFar : float = 0.7

func printPhoto(size : Vector2, items : Array[Sprite2D], background : Sprite2D):
	background.position = Vector2(0,0)
	add_child(background)
	#Faire les maths pour recalculer la position des items proprement par rapport au x,y
	#Pour l'instant on reprend la position pure
	
	# TODO : il faut ordonner par y => les plus au fond doivent être ajoutés en premier
	# pour que Godot gère tout seul la notion de profondeur
	for item in items:
		item.position.x = item.position.x * size.x - 0.5 * size.x
		item.position.y = (1 -item.position.y) * (yMax - yMin) * size.y - 0.5 * size.y
		add_child(item)
