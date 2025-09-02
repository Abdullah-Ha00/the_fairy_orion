extends Node2D
var dialogue_one = " ORION is a fairy who was born\n with strange powers."
var dialogue_two = " He lives with his chidhood friend, \n Selene, a mystical parrot."
var dialogue_three= " The world is not a safe place for both of them, \n as they are troubled by the furious beast, Teratos"
var dialogues = [dialogue_one,dialogue_two, dialogue_three]
var displayed_words = ""
var dialogue_number = 0
var can_skip = false
var can_start = false
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	$StartGameComponents.global_position = Vector2(600,200)
	get_tree().paused = true
	GlobalFunctions.can_pause_game = false
	await get_tree().create_timer(0.05).timeout
	process_dialogue()
	
func _process(_delta: float) -> void:
	if can_start or Input.is_action_pressed("accept"):
		get_tree().paused = false
		GlobalFunctions.can_pause_game = true
		queue_free()
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attach action") and can_skip:
		if dialogue_number <int(dialogues.size() - 1):
			dialogue_number +=1
			process_dialogue()
			displayed_words = ""
			can_skip =false
		else:
			can_start = true
		
func process_dialogue():
	for letters in dialogues[dialogue_number]:
		await get_tree().create_timer(0.02).timeout
		displayed_words +=letters
		$StartGameComponents/DialogueBar.text = displayed_words
		$CanPressSpaceTimer.start()
		


func _on_can_press_space_timer_timeout() -> void:
	can_skip = true 
