extends Node2D
var fairy_down_text:String = "Game Over!\nYou have been defeated!"
var parrot_down_text: String = "Game Over!\nSelene is deaaaaaaaaaaaaad!😭"
var monster_down_text:String = "You have defeated the monster! \nSelene's curse has been lifted!"
var text_y_position = 500
var high_score = ScoreManager.load_score()

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	set_up_score_values()
	pause_game()
	show_text()
	show_score()
	show_high_score_label()
	await get_tree().create_timer(16).timeout
	go_to_main_menu()
	
func show_text():
	$TextResult.global_position = Vector2(600,-100)
	_select_text()
	var text_tweens = create_tween()
	text_tweens.tween_property($TextResult,"global_position:y", text_y_position, 5)
	
func show_score():
	$ScoreDisplay.global_position = Vector2(300,300)
	await get_tree().create_timer(7).timeout
	$TextResult.hide()
	for text in $ScoreDisplay.get_children():
		await get_tree().create_timer(1).timeout
		text.visible = true
		
func pause_game():
	get_tree().paused = true
	GlobalFunctions.can_press_pause = false

func go_to_main_menu():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
	
func _select_text():
	if GlobalFunctions.fairy_health <=0:
		$TextResult.text = fairy_down_text
	elif GlobalFunctions.parrot_health <=0:
		$TextResult.text = parrot_down_text
	elif GlobalFunctions.monster_health <=0:
		$TextResult.text = monster_down_text
		
func show_high_score_label():
	$NewHighScoreLabel.global_position = Vector2(600,700)
	if GlobalFunctions.high_score < GlobalFunctions.score:
		await get_tree().create_timer(13).timeout
		$NewHighScoreLabel.visible = true

func set_up_score_values():
	$ScoreDisplay/ScoreNumber.text  =str(GlobalFunctions.score)
	$ScoreDisplay/HIghScoreNumber.text = str(GlobalFunctions.high_score)
