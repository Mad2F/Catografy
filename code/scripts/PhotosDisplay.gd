extends Node

func _ready():
	var background := Sprite2D.new()
	var i : int = 0
	for items in Global.items_in_photos:
		#var frame = Sprite2D.new()
		#frame.texture = $Frame.texture
		#frame.position.x = $Frame.position.x * (3*i + 1)
		#frame.position.y = $Frame.position.y
		
		var photoprinter = PhotoPrinter.new()
		
		#add_child(frame)
		
		var ref_frame = get_node("Frames/"+str(i))
		
		photoprinter.printPhoto(0.75 * ref_frame.get_rect().size, items, background)
		ref_frame.hide()
		i = i + 1
		
