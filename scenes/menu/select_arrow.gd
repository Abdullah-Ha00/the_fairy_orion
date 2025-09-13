extends TextureRect
class_name MovingArrow
var min_y_pos = 415
var max_y_pos = 515
var y_pos = global_position.y:
	set(value):
		global_position = Vector2(global_position.x, clamp(value,min_y_pos,max_y_pos))	
	get:
		return global_position.y
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("down") and y_pos < max_y_pos :
		y_pos+= 100
		play_sound()
	if event.is_action_pressed("up") and y_pos > min_y_pos:
		y_pos -=100
		play_sound()
	
func play_sound():
	var cursor_sound = AudioStreamPlayer.new()
	cursor_sound.bus = "SFX"
	cursor_sound.volume_db = -10
	cursor_sound.stream = load("res://audio/sfx/90s-game-ui-10-185103.mp3")
	get_tree().root.add_child(cursor_sound)
	cursor_sound.play()
	
