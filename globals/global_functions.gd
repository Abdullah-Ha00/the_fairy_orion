extends Node


func check_arrow_buttons_collision(arrow:TextureRect):
	for button in get_tree().get_nodes_in_group("Buttons"):
		if arrow.get_global_rect().has_point(button.global_position):
			button.grab_focus()
			
func change_color_on_hit(body:Node):
	if body.health>0 and is_instance_valid(body):
		body.modulate = Color.RED
		await get_tree().create_timer(0.1).timeout
		if is_instance_valid(body):
			body.modulate= body.self_modulate
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_music"):
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"),
		not AudioServer.is_bus_mute(AudioServer.get_bus_index("Music")))

func play_sound(file:String, volume:int):
	var sound = AudioStreamPlayer.new()
	sound.bus = "SFX"
	sound.volume_db = volume
	sound.stream = load(file)
	sound.stream_paused = PROCESS_MODE_ALWAYS
	get_tree().root.add_child(sound)
	sound.play()
	sound.connect("finished", Callable(sound, "queue_free"))
