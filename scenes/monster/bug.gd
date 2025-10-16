extends CharacterBody2D
class_name Bug
var direction:Vector2
var speed:int = 200
var magic_debuff_sound:String = "res://audio/sfx/magic_parry-301969.mp3"

func _ready() -> void:
	pass
	
func  _process(delta: float) -> void:
	update_velocity(delta)
	collide_fairy()
	
func update_velocity(delta:float):
		if is_instance_valid(GlobalStats.fairy_node):
			look_at(GlobalStats.fairy_node.position)
			direction= (GlobalStats.fairy_node.position - position).normalized()
			velocity = direction * speed *delta
		
func collide_fairy():
	var collision = move_and_collide(velocity)
	if collision:
		decrease_fairy_stats()
		queue_free()
		
func decrease_fairy_stats():
	GlobalStats.fairy_node.magic -= 3
	GlobalStats.fairy_node.update_magic_text()
	GlobalFunctions.change_color_on_hit(GlobalStats.fairy_node, Color.BLUE_VIOLET)
	GlobalFunctions.play_sound(magic_debuff_sound, 5)
	

func _on_remove_timeout() -> void:
	queue_free()
