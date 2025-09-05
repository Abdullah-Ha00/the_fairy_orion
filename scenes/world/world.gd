extends Node2D
var sword_beam_scene:PackedScene = preload("res://scenes/special_attacks/sword_beam.tscn")
var orb_scene:PackedScene = preload("res://scenes/special_attacks/black_orb.tscn")
var end_game_scene: PackedScene = preload("res://scenes/end_game/end_game.tscn")
var dialogues_scene: PackedScene = preload("res://scenes/dialogues/dialogues.tscn")
var shock_damage = 5
var fence_speed = 50
var monster_state:String
var parrot_state:String
var parrot_hit_processed = false
var process = true

func _ready() -> void:
	GlobalFunctions.score = 0
	$ShootingStars.emitting = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	initialize_dialogues()
	
	#print(high_score)
	
func _on_fence_player_shocked() -> void:
	$Fairy.fairy_position.x=$Fairy.position.x -50
	$Fairy.position.x = $Fairy.fairy_position.x
	$Fairy.is_moving=false
	$Fairy.can_cast_sword_beam =false
	$Fairy.health -=shock_damage
	$Fairy/ShockTimer.start()
	

func _process(_delta: float) -> void:
	update_body_states()
	for body in get_tree().get_nodes_in_group("Body"):
		if body.health <=0:
			GlobalFunctions.is_game_finished = true
			GlobalStats.dead_body = body
			body.queue_free()
			get_score()
			await get_tree().create_timer(0.1).timeout
			display_game_result()
			
	#if GlobalFunctions.monster_health <=GlobalFunctions.monster_half_health and not GlobalFunctions.is_monster_half_health:
		#increase_monster_speed()
		#GlobalFunctions.is_monster_half_health =true
		#_load_dialogues_scene()
		
	#if GlobalFunctions.is_parrot_hit and GlobalFunctions.is_parrot_already_hit:
		#_load_dialogues_scene()
		#GlobalFunctions.is_parrot_already_hit= false
	if  monster_state== "second_phase":
		begin_second_phase()
		
	if parrot_state =="hit":
		parrot_hit()

	 
func _sword_beam_action(pos) -> void:
	var sword_beam_instance = sword_beam_scene.instantiate()
	$SpecialAttacks.add_child(sword_beam_instance)
	sword_beam_instance.position = pos

func _black_orb_action(pos) -> void:
	var orb_instance = orb_scene.instantiate() as Area2D
	$SpecialAttacks.add_child(orb_instance)
	orb_instance.position = pos
	
func _on_fence_move_left() -> void:
	if  $Fence.position.x >340:
		var fence_animation_tween=create_tween()
		fence_animation_tween.tween_property($Fence,"position:x",$Fence.position.x-fence_speed,2)
				#$Fence.position.x -= 50
func begin_second_phase():
	if is_instance_valid(GlobalStats.monster_node) and process:
		$Monster.speed = 650
		$Fence/MoveLeft.start()
		GlobalStats.selected_dialogue = GlobalStats.dialogues[2]
		_load_dialogues_scene()
		process = false
		
func get_score():
		if $Monster.health <=0:
			GlobalFunctions.score = int(($Parrot/TimeLeft. time_left *10) + ($Fairy.health * 5))
			ScoreManager.save_score(GlobalFunctions.score)
			
func display_game_result():
	var end_game_instance = end_game_scene.instantiate()
	self.add_child(end_game_instance)
	
func _load_dialogues_scene():
	if not GlobalFunctions.is_game_finished: 
		var dialogues_instance = dialogues_scene.instantiate()
		self.add_child(dialogues_instance)

func initialize_dialogues():
	GlobalFunctions.is_parrot_dialogues_finished = false
	GlobalFunctions.is_monster_dialogues_finished = false
	
func update_body_states():
	if is_instance_valid(GlobalStats.monster_node):
		monster_state = GlobalStats.monster_node.current_state
	if is_instance_valid(GlobalStats.parrot_node):
		parrot_state = GlobalStats.parrot_node.current_state
func parrot_hit():
	if not parrot_hit_processed:
		print("tuj")
		parrot_hit_processed = true
		
		
		
		
		
		
