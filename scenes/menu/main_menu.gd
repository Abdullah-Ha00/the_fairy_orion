extends Node2D
@onready var music_level:float = linear_to_db(Settings.load_music_volume())
@onready var sfx_level:float = linear_to_db(Settings.load_sfx_volume())

func _ready() -> void:
	await get_tree().process_frame
	call_deferred("set_up_mouse")
	GlobalStats.button_group = "Buttons"
	show_high_score()
	GlobalFunctions.connect_buttons("Buttons", _on_button_pressed)
	GlobalFunctions.check_arrow_buttons_collision(%SelectArrowMain, GlobalStats.button_group)
	initialize_game_state()
	initialize_audio()
	
func _process(_delta: float) -> void:
	rotate_fairies()
	check_arrow()
	
func _on_button_pressed(button:Button):
	match button.name:
		"Start":
			#get_tree().change_scene_to_file("res://scenes/world/second_battle.tscn")
			GlobalFunctions.disable_buttons("Buttons")
			load_battle_menu()
		"Quit":
			get_tree().quit()
		"Options":
			GlobalFunctions.disable_buttons("Buttons")
			load_options_menu()
	GlobalFunctions.check_arrow_buttons_collision(%SelectArrowMain, GlobalStats.button_group)
	
func show_high_score():
	$HighScoreText.text = str(ScoreManager.load_score(GlobalStats.levels["0-2"]))
	
func initialize_game_state():
	GlobalStats.current_dialogue = GlobalStats.dialogues["introduction"]
	GlobalStats.current_game_phase = GlobalStats.game_phases["begin"]
	GlobalStats.is_game_finished = false
	GlobalStats.score = 0

func rotate_fairies():
	for fairy in get_tree().get_nodes_in_group("Fairies"):
		fairy.rotation_degrees += 2.5

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("accept"):
		$Audio/Accept.play()
	
func load_options_menu():
	var options_scene = preload("res://scenes/menu/ui_options.tscn")
	var options_instance = options_scene.instantiate()
	%OptionComponents.add_child(options_instance)
	change_arrow_settings(Vector2(750,560), 560, 560)

func set_up_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	DisplayServer.warp_mouse(Vector2(1000,350))


func change_arrow_settings(pos:Vector2, min_y_pos:int, max_y_pos:int):
	$%SelectArrowMain.position = pos
	$%SelectArrowMain.min_y_pos = min_y_pos
	$%SelectArrowMain.max_y_pos= max_y_pos
 
func check_arrow():
	if GlobalStats.arrow_reset:
		change_arrow_settings(Vector2(726,226), 226, 426)
		GlobalFunctions.check_arrow_buttons_collision(%SelectArrowMain, GlobalStats.button_group)
		GlobalStats.arrow_reset = false

func initialize_audio():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),music_level)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),sfx_level)

func load_battle_menu():
	var battle_scene = preload("res://scenes/menu/battle_selection.tscn")
	var battle_instance = battle_scene.instantiate()
	%BattleSelection.add_child(battle_instance)
	change_arrow_settings(Vector2(745,226), 226, 426)
