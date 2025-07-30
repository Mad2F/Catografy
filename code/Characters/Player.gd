class_name Player
extends CharacterBody2D

@export var move_speed : float = 100
@export var turn_speed : float = 10

func _process(delta):
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * move_speed
	move_and_slide()
