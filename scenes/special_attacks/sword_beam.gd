extends Area2D
var speed:int = 500
var direction:Vector2 = Vector2.RIGHT
var collision_sound:String = "res://audio/sfx/explosion-36210.mp3"
var bug_squish_sound:String = "res://audio/sfx/goopy-slime-20-229635.mp3"
func _ready() -> void:
	$RemoveLaserTimer.start()
	$Audio/Sfx.play()
	
func _process(delta: float) -> void:
	position += speed*direction*delta

func _on_remove_laser_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Bugs"):
		GlobalFunctions.play_sound(bug_squish_sound,0)
		body.queue_free()
	else:
		body.health-=GlobalStats.fairy_node.beam_damage
		body.update_health_text()
		GlobalFunctions.change_color_on_hit(body, Color.RED)
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if GlobalStats.current_game_phase =="normal":
		GlobalFunctions.play_sound(collision_sound,0)
		queue_free()
		area.queue_free() 
	else:
		queue_free()

	
