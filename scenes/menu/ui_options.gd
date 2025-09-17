extends Node2D
func _ready() -> void:
	print($Music/Slider.value)
	$AudioMusic.play()


func _on_back_pressed() -> void:
	$AudioSFX.play()


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),linear_to_db(value))
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"),value<0.05)


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),linear_to_db(value))
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"),value<0.05)
