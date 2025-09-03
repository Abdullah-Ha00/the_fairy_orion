extends Node2D
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#print($MenuComponents/SelectArrowMain.global_position.y)
	initialize_game_state()
	initialize_score()
	initialize_dialogues()
	initialize_body_states()
	connect_buttons()	
	
func _process(_delta: float) -> void:
	GlobalFunctions.check_arrow_buttons_collision($MenuComponents/SelectArrowMain)
	$MenuComponents/SelectArrowMain.check_arrow_events()
	for fairy in get_tree().get_nodes_in_group("Fairies"):
		fairy.rotation_degrees += 2.5
		
func _on_button_pressed(button:Button):
	match button.name:
		"StartButton":
			get_tree().change_scene_to_file("res://scenes/world/world.tscn")
		"QuitButton":
			get_tree().quit()
			
func initialize_body_states():
	GlobalFunctions.is_monster_half_health = false
	GlobalFunctions.is_parrot_already_hit = true
	GlobalFunctions.is_parrot_hit = false
	
func initialize_score():
	$HighScoreText.text = str(ScoreManager.load_score())
	GlobalFunctions.score = 0
	
func initialize_dialogues():
	GlobalFunctions.is_parrot_dialogues_finished = false
	GlobalFunctions.is_monster_dialogues_finished = false
	
func initialize_game_state():
	GlobalFunctions.is_game_started = true
	GlobalFunctions.is_game_finished = false
	
func connect_buttons():
	for button in get_tree().get_nodes_in_group("Buttons"):
		button.pressed.connect(_on_button_pressed.bind(button))
		
	
