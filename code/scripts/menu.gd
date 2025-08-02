extends Node2D

signal play()
signal credits()

func _on_play_pressed() -> void:
	play.emit()


func _on_credits_pressed() -> void:
	credits.emit()
