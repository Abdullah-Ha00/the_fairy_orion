extends Node2D
var fairy_down_text:String = "Game Over! You couldn't resuce your friend!"
var parrot_down_text: String = "Game Over! Your friend is \ndeaaaaaaaaaaaaad!😭"
var monster_down_text:String = "You have deafeated the monster! Your friend is now free!"
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	pause_game()
	show_text()
	await get_tree().create_timer(5).timeout
	go_to_main_menu()
	
func show_text():
	_select_text()
	$TextResult.global_position = Vector2(750,1300)
	var text_tweens = create_tween()
	text_tweens.tween_property($TextResult,"visible",true,1)
	text_tweens.tween_property($TextResult,"position:y", 500, 3)
func pause_game():
	get_tree().paused = true
	GlobalFunctions.can_pause_game = false

func go_to_main_menu():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
	
func _select_text():
	if GlobalFunctions.fairy_health <=0:
		$TextResult.text = fairy_down_text
	elif GlobalFunctions.parrot_health <=0:
		$TextResult.text = parrot_down_text
