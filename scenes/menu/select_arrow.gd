extends TextureRect
class_name MovingArrow
var min_y_pos = 419
var max_y_pos = 515
var file_path:String= "res://audio/sfx/90s-game-ui-10-185103.mp3"
var y_pos = global_position.y:
	set(value):
		global_position = Vector2(global_position.x, clamp(value,min_y_pos,max_y_pos))	
	get:
		return global_position.y
func _ready() -> void:
	GlobalFunctions.check_arrow_buttons_collision(self)
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("down") and y_pos < max_y_pos :
		y_pos+= 100
		GlobalFunctions.play_sound(file_path, -10)
		GlobalFunctions.check_arrow_buttons_collision(self)
	if event.is_action_pressed("up") and y_pos > min_y_pos:
		y_pos -=100
		GlobalFunctions.play_sound(file_path, -10)
		GlobalFunctions.check_arrow_buttons_collision(self)
	
	

	
