extends Node

@export var yMin : float = 0
@export var yMax : float = 0.75
@export var scaleClose : float = 1.
@export var scaleFar : float = 0.7

func printPhoto(size : Vector2, items : Array[Sprite2D], background : Sprite2D):
	#background.position = Vector2(0,0)
	#add_child(background)
	#Faire les maths pour recalculer la position des items proprement par rapport au x,y
	#Pour l'instant on reprend la position pure
	
	# TODO : il faut ordonner par y => les plus au fond doivent être ajoutés en premier
	# pour que Godot gère tout seul la notion de profondeur
	var sub_items : Array[Sprite2D] = []
	for item in items:
		if (item.position.x > 0 and item.position.x < 1 and 
			item.position.y > 0 and item.position.y < 1):
			item.position.x = item.position.x * size.x - 0.5 * size.x
			item.position.y = (1 -item.position.y) * (yMax - yMin) * size.y - 0.5 * size.y
			sub_items.append(item)
		#else:
			#print(str(item.texture.resource_path) + " at " + str(item.position.x) + ", " + str(item.position.x) + " hors champs")
	return items

func _ready():
	var background := Sprite2D.new()
	var i : int = 0
	for items in Global.items_in_photos:
		var ref_frame = get_node("Frames/"+str(i))
		print("Index " + str(i) + str(ref_frame.position) + str(ref_frame.size))
		
		var new_items = printPhoto(ref_frame.size, items, background)
		for item in new_items:
			print(item.texture.resource_path + " " + str(item.position) + " > " + str(item.position + ref_frame.position))
			item.position = item.position + ref_frame.position + 0.5 * ref_frame.size
			item.z_index = 100
			add_child(item)
		
		#ref_frame.hide()
		i = i + 1
		
