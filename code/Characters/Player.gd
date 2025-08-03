class_name Player
extends CharacterBody2D

@export var move_speed : float = 200
@export var turn_speed : float = 10
@onready var sprite : AnimatedSprite2D = $Sprite2D

var _pickedItem : Node2D = null

func _ready():
	$Sprite2D.play("idle")
	
func _process(_delta):
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * move_speed
	if _pickedItem != null:
		_pickedItem.global_position = global_position #+ Vector2(35, 0)
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
	if (_pickedItem != null):
		drop()
	
	else:
		for i in get_slide_collision_count():
			var collider = get_slide_collision(i).get_collider()								
			pick_up(collider)			
	
func _physics_process(_delta):
	if Input.is_action_just_pressed("main_action"):
		try_drop_or_pick()

func pick_up(collider):
	var isCat = (collider is Cat)
		
	var hasPickableItemAsChild = false
	var nodeCollider : Node2D = collider
	if nodeCollider:
		for child in nodeCollider.get_children():
			if child is PickableItem:									
				hasPickableItemAsChild = true
	
	if not isCat and not hasPickableItemAsChild:
		#you can not pick up any item that is not a cat or do not have a PickableItem
		return
	
	_pickedItem = collider
		
	for child in _pickedItem.get_children():
		if child is CollisionShape2D:
			child.disabled = true
	
	if collider is Cat:
		collider.picked.emit(true)
	else:
		if !$PickupSound.is_playing():
			$PickupSound.play()	

func drop():
	if _pickedItem:
		for child in _pickedItem.get_children():
			if child is CollisionShape2D:
				child.disabled = false
		
		if _pickedItem is Cat:
			_pickedItem.picked.emit(false)
		else:
			if !$PickupSound.is_playing():
				$PickupSound.play()	
				
		_pickedItem.position.x += 35
		_pickedItem = null
