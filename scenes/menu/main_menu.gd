extends Node2D
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	show_high_score()
	connect_buttons()
	initialize_game_state()
	
func _process(_delta: float) -> void:
	update_arrow()
	rotate_fairies()
		
func _on_button_pressed(button:Button):
	match button.name:
		"StartButton":
			get_tree().change_scene_to_file("res://scenes/world/world.tscn")
		"QuitButton":
			get_tree().quit()
			
func show_high_score():
	$HighScoreText.text = str(ScoreManager.load_score())
	
func connect_buttons():
	for button in get_tree().get_nodes_in_group("Buttons"):
		button.pressed.connect(_on_button_pressed.bind(button))

func initialize_game_state():
	GlobalStats.current_dialogue = GlobalStats.dialogues["introduction"]
	GlobalStats.current_game_phase = GlobalStats.game_phases["begin"]
	GlobalStats.is_game_finished = false
	GlobalStats.score = 0

func update_arrow():
	GlobalFunctions.check_arrow_buttons_collision($MenuComponents/SelectArrowMain)
	$MenuComponents/SelectArrowMain.check_arrow_events()

func rotate_fairies():
	for fairy in get_tree().get_nodes_in_group("Fairies"):
		fairy.rotation_degrees += 2.5
		
	
