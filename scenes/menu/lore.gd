extends Node2D

func _ready() -> void:
	scroll_mouse_entered()
	scroll_mouse_exited()
	enable_scroll()
	
	
func scroll_mouse_entered():
	for scroll in get_tree().get_nodes_in_group("Scroll"):
		scroll.mouse_entered.connect(_on_mouse_entered.bind(scroll))

func _on_mouse_entered(scroll:Area2D):
	if Scrolls.scrolls[scroll.name] == "collected":
		match_scroll_collected(scroll)
	else:
		match_scroll_locked(scroll)

func scroll_mouse_exited():
	for scroll in get_tree().get_nodes_in_group("Scroll"):
		scroll.mouse_exited.connect(_on_mouse_exited)

func _on_mouse_exited():
	$ScrollDescription.text = ""
	
func enable_scroll():
	for scroll in get_tree().get_nodes_in_group("Scroll"):
		if Scrolls.scrolls[scroll.name] == "collected":
			scroll.modulate = Color(255,255,255)
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
	
