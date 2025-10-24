extends Node2D

func _ready() -> void:
	global_position = Vector2(390,190)
	GlobalFunctions.connect_buttons("BattleButtons", _on_button_pressed)
	

func _on_button_pressed(button:Button):
	match button.name:
		"Battle1":
			get_tree().quit()
