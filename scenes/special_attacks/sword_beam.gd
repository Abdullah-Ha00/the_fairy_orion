extends Area2D
var speed:int = 500
var direction:Vector2 = Vector2.RIGHT
var is_projectile:bool = true
var laser_damage:int = 15
func _ready() -> void:
	$RemoveLaserTimer.start()
	$sfx.play()
	
func _process(delta: float) -> void:
	position += speed*direction*delta

func _on_remove_laser_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_enemy ==true or body.is_ally ==true:
		body.health-=laser_damage
		body.update_health_text()
		GlobalFunctions.change_color_on_hit(body)
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_projectile and GlobalStats.current_game_phase =="normal":
		queue_free()
		area.queue_free() 
	else:
		queue_free()
