extends Label
var string = "Hello! "
var srting_2 = "I love pasta"
var string_3 = "I love it with lemon!"
var string_4 = "I can't skip on week!"
var strings = [string, srting_2, string_3, string_4]
var number = 0
var result_text =""
var can_skip = false
enum MonsterStates {NORMAL, SECONDPHASE, DEAD}
enum FairyStates {NORMAL,SHOCK, DEAD}
enum ParrotStates {IDLE, HIT,DEAD}
enum WallStates {IDLE, MOVING}
var target_dead:String

func _ready() -> void:
	var fairy_status = FairyStates.DEAD
	if fairy_status ==FairyStates.DEAD:
		target_dead = "Fairy"
	print(target_dead)
	match target_dead:
		"Monster":
			print("tuj")
		"Fairy":
			print("rara")
		"Parrot":
			print("hiai")
	
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
