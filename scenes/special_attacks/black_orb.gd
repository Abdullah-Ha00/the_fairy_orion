extends Area2D
var speed:int = 1000
var direction:Vector2 = Vector2.LEFT
var orb_damage:int= 15

func _ready() -> void:
	$sfx.play()
	
func _process(delta: float) -> void:
	position += speed*direction*delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() 

func _on_body_entered(body: Node2D) -> void:
	if is_instance_valid(body):
		body.health -=orb_damage
		body.update_health_text()
		GlobalFunctions.change_color_on_hit(body)
	queue_free() 
