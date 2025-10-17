extends Monster
var in_range:bool = false


func emit_orb():
	if in_range:
		super()

func _on_attack_range_body_entered(_body: Node2D) -> void:	
	in_range = true

func _on_attack_range_body_exited(_body: Node2D) -> void:
	in_range = false
