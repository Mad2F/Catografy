class_name PickableItem
extends Node

var _isPicked : bool = false

func pick():
	print("Item Picked !")
	_isPicked = true
	
func drop():
	print("Item Dropped !")
	_isPicked = false
