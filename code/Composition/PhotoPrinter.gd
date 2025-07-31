extends Node

func printPhoto(items : Array[Sprite2D], background : Sprite2D):
	background.position = Vector2(0,0)
	add_child(background)
	#Faire les maths pour recalculer la position des items proprement par rapport au x,y
	#Pour l'instant on reprend la position pure
	
	# TODO : il faut ordonner par y => les plus au fond doivent être ajoutés en premier
	# pour que Godot gère tout seul la notion de profondeur
	for item in items:
		add_child(item)
