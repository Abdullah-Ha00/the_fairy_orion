extends Monster
var in_range:bool = false
signal cursed_orb

func emit_orb():
	if in_range:
		super()

func _on_attack_range_body_entered(_body: Node2D) -> void:	
	in_range = true

func _on_attack_range_body_exited(_body: Node2D) -> void:
	in_range = false


func _on_cursed_orb_cooldown_timeout() -> void:
	if GlobalStats.current_game_phase == GlobalStats.game_phases["monster_health_halved"]:
		cursed_orb.emit()
