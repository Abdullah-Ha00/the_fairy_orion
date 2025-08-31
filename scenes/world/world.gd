extends Node2D
var sword_beam_scene:PackedScene = preload("res://scenes/special_attacks/sword_beam.tscn")
var orb_scene:PackedScene = preload("res://scenes/special_attacks/black_orb.tscn")
var end_game_scene: PackedScene = preload("res://scenes/end_game/end_game.tscn")
var shock_damage = 5
var fence_speed = 50
var monster_half_health_reach = false
var score = 0
var high_score =ScoreManager.load_score()

func _ready() -> void:
	$ShootingStars.emitting = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	#print(high_score)
	
func _on_fence_player_shocked() -> void:
	$Fairy.fairy_position.x=$Fairy.position.x -50
	$Fairy.position.x = $Fairy.fairy_position.x
	$Fairy.is_moving=false
	$Fairy.can_cast_sword_beam =false
	$Fairy.health -=shock_damage
	$Fairy/ShockTimer.start()
	

func _process(_delta: float) -> void:
	for body in get_tree().get_nodes_in_group("Body"):
		if body.health <=0:
			body.queue_free()
			await get_tree().create_timer(0.1).timeout
			display_game_result()
			get_score()
	if $Monster.health <=$Monster.half_health and not monster_half_health_reach:
		increase_monster_speed()
		monster_half_health_reach =true
	
	


func _sword_beam_action(pos) -> void:
	var sword_beam_instance = sword_beam_scene.instantiate()
	$SpecialAttacks.add_child(sword_beam_instance)
	sword_beam_instance.position = pos
	
	

func _black_orb_action(pos) -> void:
	var orb_instance = orb_scene.instantiate() as Area2D
	$SpecialAttacks.add_child(orb_instance)
	orb_instance.position = pos
	
	


func _on_fence_move_left() -> void:
	if $Monster.health <=$Monster.half_health and $Fence.position.x >340:
		var fence_animation_tween=create_tween()
		fence_animation_tween.tween_property($Fence,"position:x",$Fence.position.x-fence_speed,2)
				#$Fence.position.x -= 50
func increase_monster_speed():
		$Monster.speed = 650
		$Fence/MoveLeft.start()
func get_score():
		if $Monster.health <=0:
			score = int(($Parrot/TimeLeft. time_left *10) + ($Fairy.health * 5))
			ScoreManager.save_score(score)
			if high_score < score:
				print("Score: ", score, "\nHigh Score: ", high_score, "\nNew High Score!!")
			else:
				print("Score: ", score, "\nHigh Score: ", high_score)
func display_game_result():
	var end_game_instance = end_game_scene.instantiate()
	self.add_child(end_game_instance)
		
		
		
		
		
		
		
