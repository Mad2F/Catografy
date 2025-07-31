extends Node

func _ready():
	$Camera.start_loop()


func _on_camera_last_photo_taken():
	print("LAST PHOTO ;)")
	get_tree().change_scene_to_file("res://code/scenes/PhotosDisplay.tscn")
