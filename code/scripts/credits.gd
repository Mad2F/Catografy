extends Node2D

signal back()

var time : float = 0

func _on_back_pressed() -> void:
	back.emit()

func _process(delta: float) -> void:
	time += delta
	if Input.is_anything_pressed() and time > 0.5:
		back.emit()
