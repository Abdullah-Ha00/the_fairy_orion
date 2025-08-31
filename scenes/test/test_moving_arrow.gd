extends Sprite2D
var y_pos = position.y:
	set(value):
		position = Vector2(position.x, clamp(value,-300,300))
		
	get:
		return position.y
func _process(_delta: float) -> void:
	if Input.is_action_pressed("down"):
		y_pos += 10
	if Input.is_action_pressed("up"):
		y_pos -= 10
		
