extends Area2D
var speed:int = 200
var damage:int =25
var direction:Vector2

func _ready() -> void:
	if is_instance_valid(GlobalStats.fairy_node):
		direction = (GlobalStats.fairy_node.position - position).normalized()
		
func _process(delta: float) -> void:
		position += direction*speed*delta
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
