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
	deleteAllOtherScenesExcept("menu")
	createScene("menu")
	
func show_intro():
	deleteAllOtherScenesExcept("intro")
	createScene("intro")

func show_credits():
	deleteAllOtherScenesExcept("credits")
	createScene("credits")

func show_play():
	deleteAllOtherScenesExcept("game")
	createScene("game")
	
func ending():
	deleteAllOtherScenesExcept("end")
	createScene("end")

func deleteAllOtherScenesExcept(scenename) -> void:
	if credits != null and scenename != "credits":
		remove_child(credits)
		credits.back.disconnect(show_menu)
		credits.queue_free()
	if menu != null and scenename != "menu":
		remove_child(menu)
		menu.play.disconnect(show_intro)
		menu.credits.disconnect(show_credits)
		menu.queue_free()
	if intro != null and scenename != "intro":
		remove_child(intro)
		intro.skip.disconnect(show_play)
		intro.queue_free()
	if game != null and scenename != "game":
		remove_child(game)
		game.game_finished.disconnect(ending)
		game.queue_free()
	if end != null and scenename != "end":
		remove_child(end)
		end.queue_free()

func createScene(scenename) -> void:
	if credits == null and scenename == "credits":
		credits = credits_scene.instantiate()
		credits.back.connect(show_menu)
		add_child(credits)
		return
	if menu == null and scenename == "menu":
		menu = menu_scene.instantiate()
		menu.play.connect(show_intro)
		menu.credits.connect(show_credits)
		add_child(menu)
		return
	if intro == null and scenename == "intro":
		intro = intro_scene.instantiate()
		intro.skip.connect(show_play)
		add_child(intro)
		return
	if game == null and scenename == "game":
		game = game_scene.instantiate()
		game.game_finished.connect(ending)
		add_child(game)
		return
	if end == null and scenename == "end":
		end = end_scene.instantiate()
		add_child(end)
		return
