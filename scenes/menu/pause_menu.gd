extends ColorRect
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	position = Vector2(750,350)
	$QuitOptions.global_position = Vector2(0,0)
	for button in get_tree().get_nodes_in_group("Buttons"):
		button.pressed.connect(_on_button_pressed.bind(button))
		
func _process(_delta: float) -> void:
	GlobalFunctions.check_arrow_buttons_collision($SelectArrow)
	if Input.is_action_pressed("pause") and GlobalStats.can_press_pause:
		get_tree().paused = true
		visible = true
	if get_tree().paused:
		$SelectArrow.check_arrow_events()

func _on_button_pressed(button:Button):
	match button.name:
		"ResumeButton":
			get_tree().paused =false
			visible=false
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
