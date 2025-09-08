extends Node

func check_arrow_buttons_collision(arrow:TextureRect):
	for button in get_tree().get_nodes_in_group("Buttons"):
		if arrow.get_global_rect().has_point(button.global_position):
			button.grab_focus()
			
func change_color_on_hit(body:Node):
	if body.health>0:
		body.modulate = Color.RED
		await get_tree().create_timer(0.5).timeout
		body.modulate= body.self_modulate
