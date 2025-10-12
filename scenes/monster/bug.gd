extends CharacterBody2D
var is_ally:bool = false
var direction:Vector2
var speed:int = 250

func _ready() -> void:
	pass
	
func  _process(delta: float) -> void:
	update_velocity(delta)
	collide_fairy()
	
func update_velocity(delta:float):
		look_at(GlobalStats.fairy_node.position)
		direction= (GlobalStats.fairy_node.position - position).normalized()
		velocity = direction * speed *delta
		
func collide_fairy():
	var collision = move_and_collide(velocity)
	if collision:
		decrease_fairy_magic()
		queue_free()
		
func decrease_fairy_magic():
	GlobalStats.fairy_node.magic -= 3
	GlobalStats.fairy_node.update_magic_text()


	
