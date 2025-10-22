extends Fairy
var monster_in_range:bool = false
var ray_health_cost: int = 20
signal ray

func _on_ray_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Monster") and GlobalStats.current_game_phase == GlobalStats.game_phases["monster_health_halved"]:
		monster_in_range = true
		
func _on_ray_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("Monster") and GlobalStats.current_game_phase == GlobalStats.game_phases["monster_health_halved"]:
		monster_in_range = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ray_attack") and health>ray_health_cost:
		ray.emit()
		
func ray_debuff():
	health -= ray_health_cost
	update_health_text()
	GlobalFunctions.change_color_on_hit(GlobalStats.fairy_node, Color.DARK_MAGENTA)
	$RayRange.queue_free()
