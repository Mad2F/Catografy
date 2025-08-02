extends Node
class_name Game

signal game_finished()

func _ready():
	$Camera.start_loop()
	var window_size = get_viewport().get_window().size
	for child in get_node("Cats").get_children():
		child.position = Vector2(randf_range(350, window_size[0] - 80), randf_range(300, window_size[1] - 80))
		var cat_sprite = child.get_child(0) as AnimatedSprite2D
		if cat_sprite:
			cat_sprite.modulate = Color(randf(), randf(), randf(), 1.0)

func _on_camera_last_photo_taken():
	game_finished.emit()

func _on_camera_photo_taken():
	_captureSubjects()

func _captureSubjects():
	# TODO : Check for all children (inclunding player) if they are in the field of view of the camera
	# It could be fun to be able to move the camera also
	# TODO : have a "PhotoSubject" Component where 2D Camera Sprite are loaded ?
	#Placeholder : Capture Player for test purposes
	if !$Sound/CameraSound.is_playing():
		$Sound/CameraSound.play()
		await get_tree().create_timer(2.0).timeout
	if !$Sound/FlashSound.is_playing():
		$Sound/FlashSound.play()
		$flash_cone.show()
	
	var current_items : Array[Sprite2D] = [] 
		 
	var PlayerSprite := _extractSprite($Player)
	current_items.append(PlayerSprite)
	
	for cat in get_node("Cats").get_children():
		var CatSprite := _extractSprite(cat)
		current_items.append(CatSprite )
	 
	for child in get_node("MiscItems").get_children():
		var objSprite := _extractSprite(child)
		current_items.append(objSprite)
	
	Global.items_in_photos.append(current_items)
	
	await get_tree().create_timer(0.2).timeout
	$flash_cone.hide()
	$Camera.photo_ready.emit()
	
	
#TODO ERWAN ne pas mettre get_child de 0 on veut récupérer le noeud de type Sprite2D
func _extractSprite(node: Node) -> Sprite2D:
	var sprite := Sprite2D.new()
	var ref = node.get_child(0)
	if (ref is Sprite2D):
		sprite.texture = ref.texture
	elif (ref is AnimatedSprite2D):
		var frameIndex: int = ref.get_frame()
		var animationName: String = ref.animation
		var spriteFrames: SpriteFrames = ref.get_sprite_frames()
		var currentTexture: Texture2D = spriteFrames.get_frame_texture(animationName, frameIndex)
		sprite.modulate = ref.modulate
		sprite.texture = currentTexture	
	sprite.position = _to_camera_scaled_coord(node.position)
	return sprite

# Return a vector (x,y) representing the position of the item in the FOV triangle of the camera
# x = 0 : Full left in the camera FOV, x = 1 : Full Right in the camera FOV
# y = 0 : Bottom (Camera position), y = 1 : North Wall
# If this is not clear, it is on my paper on my desk :D
func _to_camera_scaled_coord(input : Vector2):
	if ($Camera.position.y == 0):
		return Vector2(0,0)
	var yMax = $Camera.position.y
	var maxDx = tan(rad_to_deg(0.5 * $Camera.fov)) * abs($Camera.position.y)
	var localDx = input.y * maxDx / yMax
	var xLocalMin = $Camera.position.x - localDx
	var xLocalMax = $Camera.position.x + localDx
	var x = (input.x - xLocalMin) / (xLocalMax - xLocalMin)	
	var y = (yMax - input.y) / yMax
	return Vector2(x, y)
