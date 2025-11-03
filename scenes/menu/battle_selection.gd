extends Node2D
var high_score_lv1:int = ScoreManager.load_score("ch0lv1")
var high_score_lv2:int = ScoreManager.load_score("ch0lv2")

func _ready() -> void:
	global_position = Vector2(390,180)
	set_up_mouse()
	initialize_buttons()
	disable_battle_button()
	
func _process(_delta: float) -> void:
	show_tooltip()
	
func _on_button_pressed(button:Button):
	match button.name:
		"Battle1":
			get_tree().change_scene_to_file("res://scenes/world/world.tscn")
			GlobalStats.current_level = GlobalStats.levels["0-1"]
		"Battle2":
			get_tree().change_scene_to_file("res://scenes/world/second_battle.tscn")
			GlobalStats.current_level = GlobalStats.levels["0-2"]
		"Back":
			return_to_main()
			enable_mouse()
	GlobalStats.button_group = "Buttons"
	
func initialize_buttons():
	GlobalStats.button_group = "BattleButtons"
	GlobalFunctions.connect_buttons("BattleButtons", _on_button_pressed)
	GlobalFunctions.connect_buttons_focused("HasToolTip", _on_button_focused)

func set_up_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	DisplayServer.warp_mouse(Vector2(-1000,-1000))
	
func return_to_main():
	GlobalFunctions.enable_buttons("Buttons")
	queue_free()
	GlobalFunctions.check_arrow_buttons_collision(GlobalStats.arrow_node, GlobalStats.button_group)
	
func show_tooltip():
	for button in get_tree().get_nodes_in_group("HasToolTip"):
		if button.has_focus():
			$ButtonsToolTips.visible = true
			break
		else:
			$ButtonsToolTips.visible = false

func enable_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	DisplayServer.warp_mouse(Vector2(1000,350))

func _on_button_focused(button:Button):
	match button.name:
		"Battle1":
			$ButtonsToolTips/Description.text = "High Score: " + str(high_score_lv1)
		"Battle2":
			set_tooltip_text()
			
func set_tooltip_text():
	if $Buttons/Battle2.disabled:
		$ButtonsToolTips/Description.text = "Reach a score of 1000\n in Battle 1 to unlock"
	else:
		$ButtonsToolTips/Description.text = "High Score: " + str(high_score_lv2)

func disable_battle_button():
	if high_score_lv1 <1000:
		$Buttons/Battle2.disabled = true
