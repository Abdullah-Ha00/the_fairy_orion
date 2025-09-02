extends Label
var string = "Hello! "
var srting_2 = "I love pasta"
var string_3 = "I love it with lemon!"
var string_4 = "I can't skip on week!"
var strings = [string, srting_2, string_3, string_4]
var number = 0
var result_text =""
var can_skip = false

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	display_dialogue()

	
func _process(_delta: float) -> void:
	pass
func display_dialogue():
	for words in strings[number]:
		await get_tree().create_timer(0.01).timeout
		result_text += words
		text = result_text
		$CanPressSpaceTimer.start()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attach action") and can_skip:
		if number<int(strings.size())-1:
			number +=1
			display_dialogue()
			result_text = ""
			can_skip = false
		else :
			get_tree().quit()
	

func _on_can_press_space_timer_timeout() -> void:
	can_skip = true # Replace with function body.
