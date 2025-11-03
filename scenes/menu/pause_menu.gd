extends ColorRect
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	set_up_mouse()
	$Audio/Pause.play(0.1)
	set_up_menu()
	GlobalFunctions.connect_buttons("Buttons", _on_button_pressed)
	
func _on_button_pressed(button:Button):
	match button.name:
		"ResumeButton":
			get_tree().paused = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			queue_free()
		"QuitToMenuButton":
			show_quit_option()
		"YesButton":
			get_tree().paused =false 
			get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
		"NoButton":
			show_pause_menu()	
	GlobalFunctions.check_arrow_buttons_collision($SelectArrow, GlobalStats.button_group)
	
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
		
func set_up_menu():
	get_tree().paused = true
	position = Vector2(750,350)
	$QuitOptions.global_position = Vector2(0,0)

func set_up_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	DisplayServer.warp_mouse(Vector2(1000,500))
