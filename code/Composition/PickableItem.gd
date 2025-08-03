class_name PickableItem
extends Node

var _isPicked : bool = false

func pick():
	_isPicked = true
	
func drop():
	_isPicked = false
