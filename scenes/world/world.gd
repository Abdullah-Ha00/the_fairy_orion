extends Node2D
class_name MainScene
var sword_beam_scene:PackedScene = preload("res://scenes/special_attacks/sword_beam.tscn")
var orb_scene:PackedScene = preload("res://scenes/special_attacks/black_orb.tscn")
var end_game_scene: PackedScene = preload("res://scenes/end_game/end_game.tscn")
var dialogues_scene: PackedScene = preload("res://scenes/dialogues/dialogues.tscn")
var pause_scene: PackedScene = preload("res://scenes/menu/pause_menu.tscn")
var parrot_state:String
var parrot_hit_processed:bool = false
var second_phase_processed:bool = false
var fence_stopped:bool = false
var high_score:int = ScoreManager.load_score()

func _ready() -> void:
	$ShootingStars.emitting = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GlobalStats.high_score = high_score
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		pause_game()
		
func _process(_delta: float) -> void:
	update_body_states()
	check_bodies_health()
	check_game_phase()
	check_body_state()
	
func _on_fence_player_shocked() -> void:
	freeze_fairy()
	
func _sword_beam_action(pos) -> void:
	var sword_beam_instance = sword_beam_scene.instantiate()
	$SpecialAttacks.add_child(sword_beam_instance)
	sword_beam_instance.position = pos

func _black_orb_action(pos) -> void:
	var orb_instance = orb_scene.instantiate() as Area2D
	$SpecialAttacks.add_child(orb_instance)
	orb_instance.position = pos
	
func _on_fence_move_left() -> void:
	if  $Fence.position.x >$Fence.x_offset_limit:
		move_fence()
	elif $Fence.position.x ==$Fence.x_at_limit and not fence_stopped:
		stop_fence()

func begin_second_phase():
	if is_instance_valid(GlobalStats.monster_node) and not second_phase_processed:
		increase_stats()
		show_monster_dialogue()
		second_phase_processed = true
		
func get_score():
		if $Monster.health <=0:
			GlobalStats.current_game_phase =GlobalStats.game_phases["monster_health_zero"]
			GlobalStats.score = int(($Parrot/Timers/TimeLeft. time_left *10) + ($Fairy.health * 5))
			ScoreManager.save_score(GlobalStats.score)
		else:
			GlobalStats.current_game_phase = GlobalStats.game_phases["self_ally_defeated"]
			
func display_game_result():
	var end_game_instance = end_game_scene.instantiate()
	self.add_child(end_game_instance)
	
func load_dialogue():
	if not GlobalStats.is_game_finished: 
		var dialogues_instance = dialogues_scene.instantiate()
		self.add_child(dialogues_instance)

	
func update_body_states():
	if is_instance_valid(GlobalStats.parrot_node):
		parrot_state = GlobalStats.parrot_node.current_state
		
func show_parrot_dialogue():
	if not parrot_hit_processed:
		GlobalStats.current_dialogue = GlobalStats.dialogues["parrot"]
		load_dialogue()
		parrot_hit_processed = true
		
func freeze_fairy():
	$Fairy.position.x-=$Fence.x_rebound
	$Fairy.is_moving=false
	$Fairy.can_cast_sword_beam =false
	$Fairy.health -=$Fence.shock_damage
	GlobalFunctions.change_color_on_hit(GlobalStats.fairy_node)
	$Audio/Sfx/Shock.play()
	$Fairy/Timers/Shock.start()

func increase_stats():
	$Monster/MonsterImg.speed_scale = 2
	$Monster.speed *= 2
	$Fence/MoveLeft.start()

func show_monster_dialogue():
	GlobalStats.current_dialogue = GlobalStats.dialogues["monster"]
	load_dialogue()
	
func check_bodies_health():
	for body in get_tree().get_nodes_in_group("Body"):
		if body.health <=0:
			GlobalStats.is_game_finished = true
			remove_body(body)
			remove_seal(body)
			get_score()
			await get_tree().create_timer(0.1).timeout
			display_game_result()
			
func remove_body(body):
	GlobalStats.dead_body = body
	body.queue_free()
	
	

func check_game_phase():
	match GlobalStats.current_game_phase:
		"second_phase":
			begin_second_phase()
			$Audio/Music/Main.pitch_scale = 1.5
		"win":
			$Audio/Music/Main.stop()
			$Audio/Music/Win.play()
		"lose":
			$Audio/Music/Main.stop()
			$Audio/Music/Lose.play()
		
	
func check_body_state():
	if parrot_state =="hit":
		show_parrot_dialogue()

func move_fence():
	$Audio/Sfx/FenceMoving.play(2)
	var tween=create_tween()
	var fence_new_position = $Fence.position.x-$Fence.x_offset
	tween.tween_property($Fence,"position:x",fence_new_position,2)
	
func stop_fence():
	GlobalStats.current_dialogue = GlobalStats.dialogues["fence"]
	load_dialogue()
	fence_stopped = true
	
func  pause_game():
	var pause_menu = pause_scene.instantiate()
	self.add_child(pause_menu)

func remove_seal(body):
	var dead_body_script = body.get_script()
	if dead_body_script == $Parrot.get_script() or dead_body_script == $Monster.get_script():
		$Seal.queue_free()

	

		
		
		
		
		
