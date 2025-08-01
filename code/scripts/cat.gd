extends CharacterBody2D
class_name Cat

#behaviors
var map = {"hiding": 10, "licking": 10, "sitting": 40, "standing": 30, "walking":40, "zoomies":25}
var total_weight : float = sum_array(map.values())
var zoomies_speed : float = 250
var walking_speed : float = 50
var picked_up : bool = false
var direction : Vector2 = Vector2(0,0)
var speed : float = 0

#time related aspects
var time : float = 0.
var frequency = 3

#signals
signal hide_cat()
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
	
func _physics_process(delta: float) -> void:
	time += delta
	
	#CHANGE BEHAVIOR EVERY 3 SECONDS IF NOT PICKED UP
	if time > frequency:
		time = 0
		
		if (picked_up == false):
			var choice = choose( )
			get_node("Sprite2D").play(choice)
			print(choice)
			
			if choice == "walking" or choice == "zoomies":
				random_direction()
				speed = walking_speed if choice == "walking" else zoomies_speed
			elif choice == "hiding":
				hide_cat.emit()
				stop_moving()
			else:
				stop_moving()
		
	if (picked_up == false and speed > 0):
		var collide = move_and_collide(direction * speed * delta)
		if collide:
			direction = direction.bounce(collide.get_normal())
				
func random_direction():
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	
func stop_moving():
	direction = Vector2(0,0)
	speed = 0

func _on_picked(up: Variant) -> void:
	if (up != picked_up):
		picked_up = up
		if (picked_up):
			get_node("Sprite2D").play("sitting")
			stop_moving()
			if !$PurrSound.is_playing():
				$PurrSound.play()
		else:
			if $PurrSound.is_playing():
				$PurrSound.stop()
