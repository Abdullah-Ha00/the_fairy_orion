extends TextureRect
class_name MovingArrow
var min_y_pos = 415
var max_y_pos = 515
var y_pos = global_position.y:
	set(value):
		global_position = Vector2(global_position.x, clamp(value,min_y_pos,max_y_pos))
		
	get:
		return global_position.y
func check_arrow_events():	
	if Input.is_action_pressed("down") :
		y_pos+= 100
	if Input.is_action_pressed("up") :
		y_pos -=100
