extends Node2D
var scroll_clickable:bool
var scroll_name:String

func _ready() -> void:
	scroll_mouse_entered()
	scroll_mouse_exited()
	enable_scroll()
	GlobalFunctions.connect_buttons("Buttons",_on_button_pressed)
	arrow_mouse_entered()
	arrow_mouse_exited()
	
func scroll_mouse_entered():
	for scroll in get_tree().get_nodes_in_group("Scroll"):
		scroll.mouse_entered.connect(_on_scroll_mouse_entered.bind(scroll))
		
	
func _on_scroll_mouse_entered(scroll:Area2D):
	if Scrolls.scrolls[scroll.name] == "collected":
		match_scroll_collected(scroll)
		scroll_clickable = true
	else:
		match_scroll_locked(scroll)

func scroll_mouse_exited():
	for scroll in get_tree().get_nodes_in_group("Scroll"):
		scroll.mouse_exited.connect(_on_scroll_mouse_exited)
		

func _on_scroll_mouse_exited():
	$ScrollDescription.text = ""
	scroll_clickable = false
	
func enable_scroll():
	for scroll in get_tree().get_nodes_in_group("Scroll"):
		if Scrolls.scrolls[scroll.name] == "collected":
			scroll.modulate = Color(1,1,1)
		else:
			pass

func match_scroll_locked(scroll:Area2D):
	match scroll.name:
		"Scroll":
			$ScrollDescription.text = "Found in \nBattle 1"
		"Scroll2":
			$ScrollDescription.text = "Found in \nBattle 2"
		"Scroll3":
			$ScrollDescription.text = "Score 800 points in \nBattle 2"
		"Scroll4", "Scroll5":
			$ScrollDescription.text = "???"

func match_scroll_collected(scroll:Area2D):
	match scroll.name:
		"Scroll":
			$ScrollDescription.text = "Tajtuj"
		"Scroll2":
			$ScrollDescription.text = "rara"
		"Scroll3":
			$ScrollDescription.text = "asjkld"
		"Scroll4":
			$ScrollDescription.text = "Mario et Luigi"
		"Scroll5":
			$ScrollDescription.text = "Mario et Luigi 2"
	scroll_name = scroll.name
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click") and scroll_clickable:
		check_selected_scroll()

func check_selected_scroll():
	match scroll_name:
		"Scroll":
			$TextBackground/Label.text = "rara"
		"Scroll2":
			$TextBackground/Label.text = "tuj"
		"Scroll3":
			$TextBackground/Label.text = "hiiii"
		"Scroll4":
			$TextBackground/Label.text = "byyyyyye"
		"Scroll5":
			$TextBackground/Label.text = "welcome!"
	$TextBackground.position = Vector2(20,-1050)

func _on_button_pressed(button:Button):
	match button.name:
		"Back":
			await get_tree().create_timer(0.05).timeout
			get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
		"Close":
			$TextBackground.position = Vector2(0,0)
			
func arrow_mouse_entered():
	for arrow in get_tree().get_nodes_in_group("Page"):
		arrow.mouse_entered.connect(_on_arrow_mouse_entered.bind(arrow))

func _on_arrow_mouse_entered(arrow:Area2D):
	match arrow.name:
		"NextPage":
			print("next")
		"PreviousPage":
			print("previous")
			
func arrow_mouse_exited():
	for arrow in get_tree().get_nodes_in_group("Page"):
		arrow.mouse_exited.connect(_on_arrow_mouse_exited.bind(arrow))

func _on_arrow_mouse_exited(arrow:Area2D):
	match arrow.name:
		"NextPage":
			print("disablenext")
		"PreviousPage":
			print("disableprevious")
