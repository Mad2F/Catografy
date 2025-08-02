extends Node2D

var intro_scene = preload("res://code/scenes/Intro.tscn")
var game_scene = preload("res://code/scenes/game.tscn")
var end_scene = preload("res://code/scenes/PhotosDisplay_2.tscn")
var intro
var game
var end

func _ready():
	intro = intro_scene.instantiate()
	intro.skip.connect(_on_intro_finished)
	add_child(intro)

func _on_intro_finished():
	remove_child(intro)
	intro.skip.disconnect(_on_intro_finished)
	intro.queue_free()
	game = game_scene.instantiate()
	game.game_finished.connect(_on_game_finished)
	add_child(game)
	
func _on_game_finished():
	remove_child(game)
	game.queue_free()
	end = end_scene.instantiate()
	add_child(end)
