extends Node2D
var displayed_words:String = ""
var dialogue_number:int = 0
var can_skip:bool = false
var can_start:bool = false
var dialogue_one = " ORION is a fairy who was born\n with strange powers."
var dialogue_two = " He lives with his chidhood friend, \n Selene, a mystical parrot."
var dialogue_three= " The world is not a safe place for both of them, \n as they are troubled by the furious beast, Teratos"
var dialogues_intro:Array= [dialogue_one,dialogue_two, dialogue_three]
var dialogues_parrot_hit: Array = ["Hello", "Tuj", "Dabla", "rara", "Mahadaasdfijsjdflk"]
var dialogues_monster_half_health :Array = ["You damned insect!", "I will show you my real power!"]
var dialogues_monster_parrot_hit:Array = ["YOU MORROON!!Have you already forgot your training??!!", "One more hit and I'm a goner!!", "Hahaahah!, Orion the Moron!", "Shut up, both of you!!"]
var selected_dialogues:Array 

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	select_dialogue()
	pause_game()
	show_dialogue()
			
func _process(_delta: float) -> void:
	if can_start or Input.is_action_pressed("accept"):
		get_tree().paused = false
		GlobalStats.can_press_pause = true
		queue_free()
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("advance_dialogue") and can_skip:
		show_next_line(selected_dialogues)
	
func _on_can_press_space_timer_timeout() -> void:
	can_skip = true 
	
func process_dialogue(dialogues_array:Array):
	for letters in dialogues_array[dialogue_number]:
		await get_tree().create_timer(0.02).timeout
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
	$DialogueScreenComponents/DialogueBar.text = displayed_words
	$CanPressSpaceTimer.start()

func pause_game():
	get_tree().paused = true
	GlobalStats.can_press_pause = false
	
func select_dialogue():
	match GlobalStats.current_dialogue:
			"intro":
				selected_dialogues = dialogues_intro
				$DialogueScreenComponents/ButtonsDescription.show()
			"second_phase":
				selected_dialogues = dialogues_monster_half_health
			"parrot_hurt":
				selected_dialogues = dialogues_monster_parrot_hit
