extends StaticBody2D

@export var maxPhotos : int = 10
@export var fov : float = 120.

signal photo_taken
signal last_photo_taken
signal photo_ready

var _photosTaken = 0


# TODO : A retirer avant de publier le jeu !!
#func _process(_delta):
#	if Input.is_action_just_pressed("take_photo"):
#		_takePhoto()
#	elif Input.is_action_just_pressed("last_photo"):
#		_photosTaken = maxPhotos
#		_on_timer_timeout()

func start_loop():
	$Timer.start()
	
func _takePhoto():
	#TODO : Faire un event probablement, la scene globale sera alors en charge de retenir la positions de tous les objets movables
	# et de générer la photo finale en fonction 
	# une animation éventuellement
	if (_photosTaken <= maxPhotos):
		photo_taken.emit()

func _on_timer_timeout():
	_takePhoto()


func _on_photo_ready() -> void:
	_photosTaken += 1
	if (_photosTaken >= maxPhotos):
		last_photo_taken.emit()
		$Timer.stop()
