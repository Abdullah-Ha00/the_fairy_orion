extends Area2D
var damage:int = 25
var monster_hit:bool = true

func _ready() -> void:
	$AnimationPlayer.play("on_ready")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Monster") and monster_hit:
		hit_monster(body)
		monster_hit = false
	elif body.is_in_group("Bugs"):
		body.queue_free()
	else:
		pass
		
func hit_monster(body):
	body.health -=damage
	body.update_health_text()
	GlobalFunctions.change_color_on_hit(GlobalStats.monster_node, Color.DARK_MAGENTA)


func _on_area_entered(area: Area2D) -> void:
	area.queue_free()
