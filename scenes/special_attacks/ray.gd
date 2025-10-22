extends Area2D
var damage:int = 25

func _ready() -> void:
	$AnimationPlayer.play("on_ready")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Monster"):
		hit_monster(body)
	else:
		body.queue_free()

func hit_monster(body):
	body.health -=damage
	body.update_health_text()
	GlobalFunctions.change_color_on_hit(GlobalStats.monster_node, Color.DARK_MAGENTA)
