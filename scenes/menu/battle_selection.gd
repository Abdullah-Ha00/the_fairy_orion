extends Node2D

func _ready() -> void:
	global_position = Vector2(390,180)
	initialize_buttons()
	

func _on_button_pressed(button:Button):
	match button.name:
		"Battle1":
			get_tree().change_scene_to_file("res://scenes/world/world.tscn")
		"Battle2":
			get_tree().change_scene_to_file("res://scenes/world/second_battle.tscn")
		"Back":
			return_to_main()
	GlobalStats.button_group = "Buttons"
	
func initialize_buttons():
	GlobalStats.button_group = "BattleButtons"
	GlobalFunctions.connect_buttons("BattleButtons", _on_button_pressed)

func return_to_main():
	GlobalFunctions.enable_buttons("Buttons")
	queue_free()
	GlobalFunctions.check_arrow_buttons_collision(GlobalStats.arrow_node, GlobalStats.button_group)
