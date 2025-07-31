extends StaticBody2D

@export var maxPhotos : int = 10

var _photosTaken = 0

func _process(delta):
	return
	
func start_loop():
	$Timer.start()
	
func _takePhoto():
	#TODO : Faire un event probablement, la scene globale sera alors en charge de retenir la positions de tous les objets movables
	# et de générer la photo finale en fonction 
	# une animation éventuellement
	print("CHEESE !")

func _on_timer_timeout():
	if (_photosTaken < maxPhotos):
		_takePhoto()
		_photosTaken += 1
	else:
		$Timer.stop()
