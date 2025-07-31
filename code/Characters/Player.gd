class_name Player
extends CharacterBody2D

@export var move_speed : float = 100
@export var turn_speed : float = 10

var _lastMainAction := 0 #to avoid spamming actions
var _pickedItem : Node2D = null

func _process(delta):
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * move_speed
	if (_pickedItem != null):
		_pickedItem.global_position += velocity * delta
	move_and_slide()
		
func try_drop_or_pick():
	_lastMainAction = Time.get_ticks_msec()
	if (_pickedItem != null):
		print("DROP !")
		_pickedItem = null
	else:
		print("Try Pick")
		for i in get_slide_collision_count():
			var collider = get_slide_collision(i).get_collider()					
			print("PICK !")
			_pickedItem = collider
	# TODO : Check if Pickable Item close to us
	# If yes, pick it and move it with us !
	
func _physics_process(delta):
	if Input.is_action_just_pressed("main_action"):
		try_drop_or_pick()
