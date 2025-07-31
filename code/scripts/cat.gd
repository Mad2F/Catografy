extends Node2D
class_name Cat

#behaviors
var map = {"hiding": 10, "licking": 10, "sitting": 40, "standing": 30, "walking":40, "zoomies":25}
var total_weight : float = sum_array(map.values())
var zoomies_speed : float = 250
var walking_speed : float = 50
var picked_up : bool = false

#time related aspects
var time : float = 0.
var frequency = 3

#signals
signal move_cat(speed)
signal hide_cat()
signal stop_moving()
signal picked(up)

static func sum_array(array):
	var sum = 0.0
	for element in array:
		sum += element
	return sum

func choose(): 
	var sseed = randf() # random uniform distributed number
	var cumulative_weight = 0.0
	for behavior in map.keys(): # for each weight we calculate cumulatives
		cumulative_weight += map[behavior] / total_weight
		if sseed <= cumulative_weight: # choose element
			return behavior
	
func _process(delta):
	time += delta
	if time > frequency:
		time = 0
		
		if (picked_up == false):
			var choice = choose()
			get_node("animation").play(choice)
			print(choice)
		
			if choice == "walking":
				var new_speed = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * walking_speed
				move_cat.emit(new_speed)
			elif choice == "zoomies":
				var new_speed = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * zoomies_speed
				move_cat.emit(new_speed)
			elif choice == "hiding":
				hide_cat.emit()
				stop_moving.emit()
			else:
				stop_moving.emit()


func _on_picked(up: Variant) -> void:
	if (up != picked_up):
		picked_up = up
		if (picked_up):
			get_node("animation").play("sitting")
			stop_moving.emit()
			if !$PurrSound.is_playing():
				$PurrSound.play()
		else:
			if $PurrSound.is_playing():
				$PurrSound.stop()
