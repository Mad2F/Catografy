extends Node2D

var map = {"hiding": 10, "licking": 10, "sitting": 40, "standing": 30, "walking":20, "zoomies":5}

# weights of values 
var total_weight : float = sum_array(map.values())

var time : float = 0.
var frequency = 3

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
		print (choose())
