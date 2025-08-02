extends Node2D

signal back()

func _on_back_pressed() -> void:
	back.emit()

func _process(_delta: float) -> void:
	if Input.is_anything_pressed():
		back.emit()
