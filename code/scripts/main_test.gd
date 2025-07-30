extends Node2D


var velocity : Vector2 = Vector2(0,0)
var moving : bool = false

func _on_cat_move_cat(speed: Variant) -> void:
	velocity = speed
	moving = true


func _on_cat_hide_cat() -> void:
	pass # Replace with function body.


func _process(delta):
	if (moving):
		get_node("Cat").position += velocity * delta


func _on_cat_stop_moving() -> void:
	velocity = Vector2(0,0)
	moving = false
