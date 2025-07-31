extends Node

func _ready():
	var background := Sprite2D.new()
	$Frame/PhotoPrinter.printPhoto(0.75 * $Frame.get_rect().size, Global.photo1, background)
