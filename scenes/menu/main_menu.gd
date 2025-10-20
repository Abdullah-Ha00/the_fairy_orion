extends Node2D
@onready var music_level:float = linear_to_db(Settings.load_music_volume())
@onready var sfx_level:float = linear_to_db(Settings.load_sfx_volume())

func _ready() -> void:
	await get_tree().process_frame
	call_deferred("set_up_mouse")
	show_high_score()
	connect_buttons()
	initialize_game_state()
	initialize_audio()
	update_button_color()
	
func _process(_delta: float) -> void:
	rotate_fairies()
	check_arrow()
	
func _on_button_pressed(button:Button):
	match button.name:
		"Start":
			get_tree().change_scene_to_file("res://scenes/world/second_battle.tscn")
		"Quit":
			get_tree().quit()
		"Options":
			disable_buttons()
			load_options_menu()
		
	update_button_color()
			
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
	GlobalFunctions.check_arrow_buttons_collision(%SelectArrowMain)
	
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
	change_arrow_settings()

func set_up_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	DisplayServer.warp_mouse(Vector2(1000,350))
	
func disable_buttons():
	for button in get_tree().get_nodes_in_group("Buttons"):
		button.disabled = true

func change_arrow_settings():
	$%SelectArrowMain.position = Vector2(750,560)
	$%SelectArrowMain.min_y_pos = 560
	$%SelectArrowMain.max_y_pos= 560
 
func reset_arrow_settings():
	$%SelectArrowMain.position = Vector2(726,226)
	%SelectArrowMain.min_y_pos = 226
	%SelectArrowMain.max_y_pos = 426

func check_arrow():
	if GlobalStats.arrow_reset:
		reset_arrow_settings()
		update_button_color()
		GlobalStats.arrow_reset = false

func initialize_audio():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),music_level)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),sfx_level)
