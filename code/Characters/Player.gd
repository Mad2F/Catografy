class_name Player
extends CharacterBody2D

@export var move_speed : float = 100
@export var turn_speed : float = 10

var _lastMainAction := 0 #to avoid spamming actions

func _process(delta):
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * move_speed
	move_and_slide()
	if Input.is_action_just_pressed("main_action"):
		try_pick()
		
func try_pick():
	_lastMainAction = Time.get_ticks_msec()
	print("Try Pick")
	# TODO : Check if Pickable Item close to us
	# If yes, pick it and move it with us !
	
func _physics_process(delta):
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider():
			print("Aouch")
	
	
