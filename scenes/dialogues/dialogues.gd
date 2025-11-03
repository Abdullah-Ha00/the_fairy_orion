extends Node2D
var displayed_words:String = ""
var dialogue_number:int = 0
var can_skip:bool = false
var can_start:bool = false
var selected_dialogues:Array 
var dialogues_level:Dictionary

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	check_level()
	select_dialogue(dialogues_level)
	pause_game()
	show_dialogue()
	
func _process(_delta: float) -> void:
	if can_start or Input.is_action_pressed("accept"):
		get_tree().paused = false
		queue_free()
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("advance_dialogue") and can_skip:
		show_next_line(selected_dialogues)
	
func _on_nex_line_timer_timeout() -> void:
	can_skip = true
	
func process_dialogue(dialogues_array:Array):
	for letters in dialogues_array[dialogue_number]:
		await get_tree().create_timer(0.015).timeout
		play_text_sound()
		displayed_words +=letters
		process_letters()

func show_dialogue():
	$DialogueScreenComponents.global_position = Vector2(600,200)
	await get_tree().create_timer(0.03).timeout
	process_dialogue(selected_dialogues)

func show_next_line(dialogues_array:Array):
	if dialogue_number <int(dialogues_array.size() - 1):
		dialogue_number +=1
		process_dialogue(selected_dialogues)
		displayed_words = ""
		can_skip =false
	else:
		can_start = true
		
func process_letters():
	$DialogueScreenComponents/DialogueBar/DialogueText.bbcode_text = displayed_words
	$NexLineTimer.start()

func pause_game():
	get_tree().paused = true
	
func select_dialogue(dialogues_path:Dictionary):
	match GlobalStats.current_dialogue:
			"intro":
				selected_dialogues = dialogues_path["intro"]
				$DialogueScreenComponents/ButtonsDescription.show()
				$Audio/Parrot.play()
			"second_phase":
				selected_dialogues = dialogues_path["second_phase"]
				$Audio/MonsterHit.play()
			"parrot_hurt":
				selected_dialogues = dialogues_path["parrot"]
			"fence_stopped":
				selected_dialogues = dialogues_path["fence"]
				$Audio/MonsterLaugh.play()
			"hint":
				selected_dialogues = dialogues_path["ray_hint"]
			"monster_hit":
				selected_dialogues = dialogues_path["ray_hit"]
				$Audio/Ray.play()

func play_text_sound():
	$Audio/Text.play()
	await get_tree().create_timer(0.08).timeout
	$Audio/Text.stop()

func check_level():
	if GlobalStats.current_level =="ch0lv1":
		dialogues_level = DialoguesPath.dialogues_ch0lv1
	else:
		dialogues_level = DialoguesPath.dialogues_ch0lv2
	
