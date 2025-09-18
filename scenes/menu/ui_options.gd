extends Node2D
func _ready() -> void:
	global_position = Vector2(380,182)

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),linear_to_db(value))
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"),value<0.05)
	update_button_color()


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),linear_to_db(value))
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"),value<0.05)
	update_button_color()

func update_button_color():
	GlobalFunctions.check_arrow_buttons_collision(GlobalStats.arrow_node)

func _on_save_pressed() -> void:
	save_volume_settings()
	enable_buttons()
	queue_free()
	update_button_color()
	
func enable_buttons():
	for button in get_tree().get_nodes_in_group("Buttons"):
		button.disabled=false
	GlobalStats.arrow_reset = true
	
func save_volume_settings():
	var sfx_volume:float = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))
	var music_volume:float = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	print(sfx_volume, music_volume)
