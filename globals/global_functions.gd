extends Node

func _ready() -> void:
	var cursor = load("res://images/mouse_cursor.png")
	Input.set_custom_mouse_cursor(cursor,Input.CURSOR_ARROW,Vector2(16,16))
	
func check_arrow_buttons_collision(arrow:TextureRect,group_name:String):
	for button in get_tree().get_nodes_in_group(group_name):
		if arrow.get_global_rect().has_point(button.global_position):
			button.grab_focus()
			
func change_color_on_hit(body:Node, color:Color):
	if body.health>0 and is_instance_valid(body):
		body.modulate = color
		await get_tree().create_timer(0.2).timeout
		if is_instance_valid(body):
			body.modulate= body.self_modulate

func play_sound(file:String, volume:int):
	var sound = AudioStreamPlayer.new()
	sound.bus = "SFX"
	sound.volume_db = volume
	sound.stream = load(file)
	sound.stream_paused = PROCESS_MODE_ALWAYS
	get_tree().root.add_child(sound)
	sound.play()
	sound.connect("finished", Callable(sound, "queue_free"))

func connect_buttons(group_name:String, method_on_press:Callable):
	for button in get_tree().get_nodes_in_group(group_name):
		button.pressed.connect(method_on_press.bind(button))

func disable_buttons(group_name:String):
	for button in get_tree().get_nodes_in_group(group_name):
		button.disabled= true

func enable_buttons(group_name:String):
	for button in get_tree().get_nodes_in_group(group_name):
		button.disabled=false
	GlobalStats.arrow_reset = true
