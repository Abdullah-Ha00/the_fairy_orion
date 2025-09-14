extends ColorRect
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	$Audio/Pause.play()
	set_up_menu()
	connect_buttons()
		
func _process(_delta: float) -> void:
	GlobalFunctions.check_arrow_buttons_collision($SelectArrow)
	
func _on_button_pressed(button:Button):
	match button.name:
		"ResumeButton":
			get_tree().paused = false
			queue_free()
		"QuitToMenuButton":
			show_quit_option()
		"YesButton":
			get_tree().paused =false 
			get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
		"NoButton":
			show_pause_menu()	
	
func show_quit_option():
	$QuitOptions.visible= true
	$QuitOptions.global_position = Vector2(710,-20)
	$PauseOptions.global_position = Vector2(0,0)
	$PauseOptions.visible = false

func show_pause_menu():
	$QuitOptions.visible= false
	$QuitOptions.global_position = Vector2(0,0)
	$PauseOptions.global_position = Vector2(750,350)
	$PauseOptions.visible = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("accept"):
		$Audio/Accept.play()
		
func connect_buttons():
	for button in get_tree().get_nodes_in_group("Buttons"):
		button.pressed.connect(_on_button_pressed.bind(button))

func set_up_menu():
	get_tree().paused = true
	position = Vector2(750,350)
	$QuitOptions.global_position = Vector2(0,0)
