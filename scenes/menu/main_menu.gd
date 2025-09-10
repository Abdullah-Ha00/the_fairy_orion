extends Node2D
var toggle_music_text:Array = ["Music: ON", "Music: OFF"]
var toggle_colors:Array = [Color.BLACK, Color.YELLOW]
var on:int = false
@onready var music_button:Node = $MenuComponents/OptionButtons/Music
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	show_high_score()
	connect_buttons()
	initialize_game_state()
	#change_music_text()
	
	
func _process(_delta: float) -> void:
	update_button_color()
	rotate_fairies()
	
		
func _on_button_pressed(button:Button):
	match button.name:
		"Start":
			get_tree().change_scene_to_file("res://scenes/world/world.tscn")
		"Quit":
			get_tree().quit()
		"Options":
			show_options()
		"Back":
			show_main_menu()
		"Music":
			change_music_text()

		
			
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

func update_button_color():
	GlobalFunctions.check_arrow_buttons_collision($MenuComponents/SelectArrowMain)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("down"):
		$MenuComponents/SelectArrowMain.check_arrow_events()
	if event.is_action_pressed("up"):
		$MenuComponents/SelectArrowMain.check_arrow_events()
		
func rotate_fairies():
	for fairy in get_tree().get_nodes_in_group("Fairies"):
		fairy.rotation_degrees += 2.5

func show_options():
	%OptionButtons.visible = true
	$%OptionButtons.global_position = Vector2(0,-300)
	%MainButtons.global_position = Vector2(0,-500)
	%MainButtons.visible = false
	%SelectArrowMain.y_pos -=200

func show_main_menu():
	%OptionButtons.visible = false
	$%OptionButtons.global_position = Vector2(0,0)
	%MainButtons.global_position = Vector2(0,0)
	%MainButtons.visible = true
	%SelectArrowMain.y_pos -=200

func change_music_text():
	on = not on
	music_button.text = toggle_music_text[on]
	%Music.modulate = toggle_colors[on]
	

	
