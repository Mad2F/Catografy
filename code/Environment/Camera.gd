extends StaticBody2D

@export var maxPhotos : int = 2
@export var fov : float = 120.

signal photo_taken
signal last_photo_taken

var _photosTaken = 0

func _process(_delta):
	return
	
func start_loop():
	$Timer.start()
	
func _takePhoto():
	#TODO : Faire un event probablement, la scene globale sera alors en charge de retenir la positions de tous les objets movables
	# et de générer la photo finale en fonction 
	# une animation éventuellement
	print("CHEESE !")
	photo_taken.emit()

func _on_timer_timeout():
	if (_photosTaken < maxPhotos):
		_takePhoto()
		_photosTaken += 1
	else:
		last_photo_taken.emit()
		$Timer.stop()
