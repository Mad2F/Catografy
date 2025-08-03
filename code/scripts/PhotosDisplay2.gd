extends Node

@export var yMin : float = 0
@export var yMax : float = 1
@export var scaleClose : float = 5.
@export var scaleFar : float = 0.5

signal back_menu()

func printPhoto(size : Vector2, items : Array[Sprite2D], parent_scale: float):
	var sub_items : Array[Sprite2D] = []
	for item in items:
		if (item.position.x > 0 and item.position.x < 1 and 
			item.position.y > 0 and item.position.y < 1):
			var scale = ((scaleFar - scaleClose) * item.position.y + scaleClose) * parent_scale
			item.position.x = item.position.x * size.x
			item.position.y = (1 -item.position.y) * (yMax - yMin) * size.y
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
		var sprite : Sprite2D = get_node("Backgrounds/"+str(i))
		sprite.z_index = z_index
		z_index += 1
		var size = Vector2(sprite.texture.get_width() * sprite.scale.x, sprite.texture.get_height() * sprite.scale.y)
		var new_items = printPhoto(size, items, sprite.scale.y)
		for item in new_items:
			#item.position.y *= 1.1 #hack
			item.position += sprite.position + Vector2(-0.5 * size[0], -0.5 * size[1])
			item.z_index = z_index
			add_child(item)	
		z_index += 1

		get_node("Backgrounds/"+str(i)).show()
		i = i + 1
	
	$Background.z_index = z_index + 1
		


func _on_back_pressed() -> void:
	back_menu.emit()
