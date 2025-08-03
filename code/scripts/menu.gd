extends Node2D

signal play()
signal credits()

func _ready():
	$Play.grab_focus()
	
func _on_play_pressed() -> void:
	play.emit()


func _on_credits_pressed() -> void:
	credits.emit()
	
func _process(_delta):
	var move = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if move.y < 0 and $Credits.has_focus():
		$Credits.release_focus()
		$Play.grab_focus()
	if move.y > 0 and $Play.has_focus():
		$Play.release_focus()
		$Credits.grab_focus()
	
	if Input.is_action_just_pressed("main_action"):
		if $Credits.has_focus():
			_on_credits_pressed()
		else:
			_on_play_pressed()
