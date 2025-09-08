extends StaticBody2D
signal player_shocked
signal move_left
var shock_damage:int = 5
var x_offset:int = 50
var x_rebound:int = 50
var x_offset_limit:int = 340
var x_at_limit:int = 326

func _on_area_2d_body_entered(body: Node2D) -> void:
	player_shocked.emit()
	body.update_health_text()

func _on_move_left_timeout() -> void:
	move_left.emit() 
