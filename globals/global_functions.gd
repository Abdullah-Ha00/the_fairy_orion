extends Node

func check_arrow_buttons_collision(arrow:TextureRect):
	for button in get_tree().get_nodes_in_group("Buttons"):
		if arrow.get_global_rect().has_point(button.global_position):
			button.grab_focus()
			
