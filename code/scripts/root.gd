extends Node2D

var intro_scene = preload("res://code/scenes/Intro.tscn")
var game_scene = preload("res://code/scenes/game.tscn")

func _ready():
	var intro = intro_scene.instantiate()
	add_child(intro)
	await get_tree().create_timer(21.0).timeout
	remove_child(intro)
	var game = game_scene.instantiate()
	add_child(game)
