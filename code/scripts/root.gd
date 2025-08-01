extends Node2D

var intro_scene = preload("res://code/scenes/Intro.tscn")
var game_scene = preload("res://code/scenes/game.tscn")
var end_scene = preload("res://code/scenes/PhotosDisplay.tscn")
var intro
var game
var end

func _ready():
	intro = intro_scene.instantiate()
	add_child(intro)
	await get_tree().create_timer(21.0).timeout
	remove_child(intro)
	game = game_scene.instantiate()
	game.game_finished.connect(_on_game_finished)
	add_child(game)

func _on_game_finished():
	remove_child(game)
	end = end_scene.instantiate()
	add_child(end)
