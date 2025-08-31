extends StaticBody2D
signal player_shocked
signal move_left
#var is_enemy = false
#var is_ally = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	player_shocked.emit()
	body.update_health_text()


func _on_move_left_timeout() -> void:
	move_left.emit() # Replace with function body.
