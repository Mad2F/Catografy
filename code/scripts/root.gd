extends Node2D

var menu_scene = preload("res://code/scenes/Menu.tscn")
var credits_scene = preload("res://code/scenes/Credits.tscn")
var intro_scene = preload("res://code/scenes/Intro.tscn")
var game_scene = preload("res://code/scenes/game.tscn")
var end_scene = preload("res://code/scenes/PhotosDisplay_2.tscn")
var intro
var game
var end
var menu
var credits

func _ready():
	show_menu()
	
func show_menu():
	menu = menu_scene.instantiate()
	menu.play.connect(show_intro)
	menu.credits.connect(show_credits)
	add_child(menu)
	
func show_intro():
	if credits != null:
		remove_child(credits)
		credits.back.disconnect(show_menu)
		credits.queue_free()
	if menu != null:
		remove_child(menu)
		menu.play.disconnect(show_intro)
		menu.credits.disconnect(show_credits)
		menu.queue_free()
	intro = intro_scene.instantiate()
	intro.skip.connect(show_play)
	add_child(intro)

func show_credits():
	credits = credits_scene.instantiate()
	credits.back.connect(show_menu)
	add_child(credits)

func show_play():
	remove_child(intro)
	intro.skip.disconnect(show_play)
	intro.queue_free()
	game = game_scene.instantiate()
	game.game_finished.connect(ending)
	add_child(game)
	
func ending():
	remove_child(game)
	game.queue_free()
	end = end_scene.instantiate()
	add_child(end)
