extends Node
var monster_health:int
var monster_half_health:int
var fairy_health:int
var parrot_health:int
var score:int
var high_score:int
var can_press_pause:bool
var is_game_started:bool
var is_game_finished:bool
var is_monster_half_health:bool 
var is_parrot_hit:bool
var is_parrot_already_hit:bool
var is_parrot_dialogues_finished:bool
var is_monster_dialogues_finished:bool


func check_arrow_buttons_collision(arrow:TextureRect):
	for button in get_tree().get_nodes_in_group("Buttons"):
		if arrow.get_global_rect().has_point(button.global_position):
			button.grab_focus()
			
