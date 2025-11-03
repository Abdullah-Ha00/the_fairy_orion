extends Node2D

func _ready() -> void:
	global_position = Vector2(385,182)
	set_sliders_values()
	
func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),linear_to_db(value))
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"),value<0.05)
	GlobalFunctions.check_arrow_buttons_collision(GlobalStats.arrow_node, GlobalStats.button_group)

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),linear_to_db(value))
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"),value<0.05)
	GlobalFunctions.check_arrow_buttons_collision(GlobalStats.arrow_node, GlobalStats.button_group)

func _on_save_pressed() -> void:
	save_volume_settings()
	GlobalFunctions.enable_buttons("Buttons")
	queue_free()
	GlobalFunctions.check_arrow_buttons_collision(GlobalStats.arrow_node, GlobalStats.button_group)
		
func save_volume_settings():
	var sfx_volume:float = $Sfx/Slider.value
	var music_volume:float = $Music/Slider.value
	Settings.save_audio_volume(music_volume,sfx_volume)

func set_sliders_values():
	$Music/Slider.value = Settings.load_music_volume()
	$Sfx/Slider.value = Settings.load_sfx_volume()
	
