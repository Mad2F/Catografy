extends Node

func _ready():
	$Camera.start_loop()


func _on_camera_last_photo_taken():
	get_tree().change_scene_to_file("res://code/scenes/PhotosDisplay.tscn")

func _on_camera_photo_taken():
	_captureSubjects()
	_showPhoto()

func _captureSubjects():
	# TODO : Check for all children (inclunding player) if they are in the field of view of the camera
	# It could be fun to be able to move the camera also
	# TODO : have a "PhotoSubject" Component where 2D Camera Sprite are loaded ?
	#Placeholder : Capture Player for test purposes
	var PlayerSprite := Sprite2D.new()
	PlayerSprite.texture = $Player.sprite.texture
	PlayerSprite.position = _to_camera_scaled_coord($Player.position)
	Global.photo1.clear()
	Global.photo1.append(PlayerSprite)
	

func _showPhoto():
	# TODO : display the current photo taken on the bottom right of the screen for a few seconds
	pass

# Return a vector (x,y) representing the position of the item in the FOV triangle of the camera
# x = 0 : Full left in the camera FOV, x = 1 : Full Right in the camera FOV
# y = 0 : Bottom (Camera position), y = 1 : North Wall
# If this is not clear, it is on my paper on my desk :D
func _to_camera_scaled_coord(input : Vector2):
	if ($Camera.position.y == 0):
		return Vector2(0,0)
	var output := Vector2(0,0)
	var yMax = $Camera.position.y
	var maxDx = tan(rad_to_deg(0.5 * $Camera.fov)) * abs($Camera.position.y)
	var localDx = input.y * maxDx / yMax
	var xLocalMin = $Camera.position.x - localDx
	var xLocalMax = $Camera.position.x + localDx
	var x = (input.x - xLocalMin) / (xLocalMax - xLocalMin)	
	var y = (yMax - input.y) / yMax
	return Vector2(x, y)
	
