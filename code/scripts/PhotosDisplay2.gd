extends Node

@export var yMin : float = 0
@export var yMax : float = 0.6
@export var scaleClose : float = 1.
@export var scaleFar : float = 0.7

func printPhoto(size : Vector2, items : Array[Sprite2D], parent_scale: float):
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
			var scale = (-4.5 * item.position.y + 5) * parent_scale
			item.position.x = item.position.x * size.x - 0.5 * size.x
			item.position.y = (1 -item.position.y) * (yMax - yMin) * size.y - 0.5 * size.y
			item.scale = Vector2(scale, scale)
			sub_items.append(item)
	return sub_items

func _ready():
	$Background.show()
	for child in $Backgrounds.get_children():
		child.hide()
	
	var i : int = 0
	var z_index = 1
	for items in Global.items_in_photos:
		print(i)
		var sprite : Sprite2D = get_node("Backgrounds/"+str(i))
		sprite.z_index = z_index
		z_index += 1
		var size = Vector2(sprite.texture.get_width() * sprite.scale.x, sprite.texture.get_height() * sprite.scale.y)
		var new_items = printPhoto(size, items, sprite.scale.y)
		for item in new_items:
			item.position = item.position + sprite.position #+ 0.5 * size
			item.z_index = z_index
			add_child(item)	
		z_index += 1

		get_node("Backgrounds/"+str(i)).show()
		i = i + 1
	
	$Background.z_index = z_index + 1
		
