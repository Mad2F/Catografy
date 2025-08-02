class_name Player
extends CharacterBody2D

@export var move_speed : float = 200
@export var turn_speed : float = 10
@onready var sprite : AnimatedSprite2D = $Sprite2D

var _lastMainAction := 0 #to avoid spamming actions
var _pickedItem : Node2D = null

func _ready():
	$Sprite2D.play("idle")
	
func _process(delta):
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * move_speed
	if _pickedItem != null:
		_pickedItem.global_position = global_position + Vector2(35, 0)
	if (velocity[0] != 0 or velocity[1] != 0) and _pickedItem != null:
		$Sprite2D.play("walking_carrying")
	if  (velocity[0] != 0 or velocity[1] != 0) and _pickedItem == null:
		$Sprite2D.play("walking")
	if (velocity[0] == 0 and velocity[1] == 0)  and _pickedItem != null:
		$Sprite2D.play("idle_carrying")
	if (velocity[0] == 0 and velocity[1] == 0)  and _pickedItem == null:
		$Sprite2D.play("idle")
		
	move_and_slide()
		
func try_drop_or_pick():
	_lastMainAction = Time.get_ticks_msec()
	if (_pickedItem != null):
		print("DROP !")
		print(_pickedItem)
		if _pickedItem is Cat:
			_pickedItem.picked.emit(false)
		_pickedItem = null
		if !$PickupSound.is_playing():
			$PickupSound.play()
	
	else:
		print("Try Pick")
		for i in get_slide_collision_count():
			var collider = get_slide_collision(i).get_collider()
			var nodeCollider : Node2D = collider
			if collider is Cat:
				_pickedItem = collider
				collider.picked.emit(true)
			else:
				for child in nodeCollider.get_children():
					if child is PickableItem:							
						print("PICK !")				
						_pickedItem = collider
						if !$PickupSound.is_playing():
							$PickupSound.play()				
	
func _physics_process(_delta):
	if Input.is_action_just_pressed("main_action"):
		try_drop_or_pick()
