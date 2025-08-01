extends Node2D
class_name Intro

func _ready():
	await get_tree().create_timer(3.0).timeout
	$First.show()
	await get_tree().create_timer(3.0).timeout
	$First.hide()
	$Second.show()
	await get_tree().create_timer(3.0).timeout
	$Second.hide()
	$Third.show()
	await get_tree().create_timer(3.0).timeout
	$Third.hide()
	$Fourth.show()
	await get_tree().create_timer(3.0).timeout
	$Fourth.hide()
	await get_tree().create_timer(3.0).timeout
	$Fifth.show()
	await get_tree().create_timer(3.0).timeout
	
	$Fifth.hide()
