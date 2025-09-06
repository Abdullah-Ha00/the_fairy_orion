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
	select_text()
	var text_tweens = create_tween()
	text_tweens.tween_property($TextResult,"global_position:y", text_y_position, 5)
	
func show_score():
	$ScoreDisplay.global_position = Vector2(300,300)
	await get_tree().create_timer(7).timeout
	hide_text()
	show_score_labels()
	
func pause_game():
	get_tree().paused = true
	GlobalStats.can_press_pause = false

func go_to_main_menu():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
	
func select_text():
	match GlobalStats.dead_body:
		GlobalStats.parrot_node:
			$TextResult.text = parrot_down_text
		GlobalStats.monster_node:
			$TextResult.text = monster_down_text
		GlobalStats.fairy_node:
			$TextResult.text = fairy_down_text

func show_high_score_label():
	$NewHighScoreLabel.global_position = Vector2(600,700)
	if GlobalStats.high_score < GlobalStats.score:
		await get_tree().create_timer(13).timeout
		$NewHighScoreLabel.visible = true

func set_up_score_values():
	GlobalStats.high_score = high_score
	$ScoreDisplay/ScoreNumber.text  =str(GlobalStats.score)
	$ScoreDisplay/HIghScoreNumber.text = str(GlobalStats.high_score)

func hide_text():
	$TextResult.hide()

func show_score_labels():
	for text in $ScoreDisplay.get_children():
		await get_tree().create_timer(1).timeout
		text.visible = true
