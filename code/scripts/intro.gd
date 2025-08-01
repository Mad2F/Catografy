extends Node2D
class_name Intro

signal skip

func _ready():
	await $initialTimer.timeout
	slideshow()
	
func slideshow():
	$First.show()
	$timer.start()
	await $timer.timeout
	$First.hide()
	$Second.show()
	await $timer.timeout
	$Second.hide()
	$Third.show()  
	await $timer.timeout
	$Third.hide()
	$Fourth.show()
	await $timer.timeout
	$Fourth.hide()
	await $timer.timeout
	$Fifth.show()
	await $timer.timeout
	$Fifth.hide()
	skip.emit()


func _on_skip_pressed() -> void:
	skip.emit()
	
func _process(_delta: float) -> void:
	if Input.is_anything_pressed():
		skip.emit()
