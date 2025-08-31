#extends Label
#var is_pause_visible = false
#func _ready():
	#process_mode = Node.PROCESS_MODE_ALWAYS
	#
	#
#
#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("pause"):
		#get_tree().paused = not get_tree().paused
		#is_pause_visible = not is_pause_visible
		#visible = is_pause_visible
		
