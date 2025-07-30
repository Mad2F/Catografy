extends Node2D

#behaviors
var map = {"hiding": 10, "licking": 10, "sitting": 40, "standing": 30, "walking":40, "zoomies":25}
var total_weight : float = sum_array(map.values())
var zoomies_speed : float = 100
var walking_speed : float = 20

#time related aspects
var time : float = 0.
var frequency = 3

#signals
signal move_cat(speed)
signal hide_cat()
signal stop_moving()

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
		var choice = choose()
		get_node("CharacterBody2D/animation").play(choice)
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
