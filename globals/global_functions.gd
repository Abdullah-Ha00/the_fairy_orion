extends Node
var monster_health:int
var monster_half_health:int
var can_pause_game:bool
var fairy_health:int
var parrot_health:int
var score:int
var high_score:int


func check_arrow_buttons_collision(arrow:TextureRect):
	for button in get_tree().get_nodes_in_group("Buttons"):
		if arrow.get_global_rect().has_point(button.global_position):
			button.grab_focus()
			
