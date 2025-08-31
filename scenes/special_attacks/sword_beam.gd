extends Area2D
var speed = 500
var direction = Vector2.RIGHT
var is_projectile = true
@export var laser_damage = 15
func _ready() -> void:
	$RemoveLaserTimer.start()
	
func _process(delta: float) -> void:
	position += speed*direction*delta

func _on_remove_laser_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_enemy ==true or body.is_ally ==true:
		body.health-=laser_damage
		body.update_health_text()
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_projectile and GlobalFunctions.monster_health > GlobalFunctions.monster_half_health:
		queue_free()
		area.queue_free() # Replace with function body.
	else:
		queue_free()
