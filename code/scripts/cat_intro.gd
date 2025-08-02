extends CharacterBody2D

enum Position {WALK, SIT, LICK, STAND, ZOOMIES}
var equivalents = {
	Position.WALK: "walking", 
	Position.SIT: "sitting", 
	Position.LICK: "licking", 
	Position.STAND: "standing",
	Position.ZOOMIES: "zoomies"
}
var catpos = Position.SIT

func _ready():
	modulate = Color(randf(), randf(), randf(), 1.0)
	slideshow()
	
	
func slideshow():
	setPosition(Position.LICK)
	await $timer.timeout
	setPosition(Position.WALK)
	await $timer.timeout
	setPosition(Position.SIT)
	await $timer.timeout
	setPosition(Position.LICK)
	await $timer.timeout
	setPosition(Position.ZOOMIES)
	await $timer.timeout

func setPosition(pos: Position):
	if catpos != pos:
		$Sprite2D.play(equivalents[pos])
		catpos = pos

func _process(delta):
	if catpos == Position.WALK:
		position.x += 100 * delta
	if catpos == Position.ZOOMIES:
		position.x += 500 * delta
