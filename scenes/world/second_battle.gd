extends MainScene
var magic_bug_scene:PackedScene = preload("res://scenes/monster/bug.tscn")
var health_bug_scene: PackedScene = preload("res://scenes/monster/bug_health.tscn")
var damage_bug_scene: PackedScene = preload("res://scenes/monster/bug_damage.tscn")
var cursed_orb_scene: PackedScene = preload("res://scenes/special_attacks/cursed_orb.tscn")
var bug_scenes:Array = [magic_bug_scene, health_bug_scene, damage_bug_scene]

func _on_summon_bugs_timeout() -> void:
	var bug_instance = bug_scenes.pick_random().instantiate()
	set_bug_random_position(bug_instance)
	self.add_child(bug_instance)
	$Timers/SummonBugs.wait_time = randi_range(5,7)

func set_bug_random_position(bug_instance):
	var positions:Array = $Fence/BugsSpawnPositions.get_children()
	var summon_position:Vector2 = positions.pick_random().global_position
	set_summon_light(summon_position)
	bug_instance.position = summon_position

func set_summon_light(pos:Vector2):
	$SummonLight.position = pos
	$AnimationPlayer.play("bug_summon_light")
	$Audio/Sfx/SummonBug.play()

func _on_move_parrot_timeout() -> void:
	if is_instance_valid(GlobalStats.parrot_node) and is_instance_valid(GlobalStats.fairy_node):
		$Audio/Sfx/MoveParrot.play()
		$Parrot.y_pos =$Fairy.position.y - 100
		$Timers/MoveParrot.wait_time = randi_range(4,7)


func _on_monster_cursed_orb() -> void:
	var cursed_orb_instance = cursed_orb_scene.instantiate()
	cursed_orb_instance.position = $Monster/CursedOrbSpawnPositions.get_children().pick_random().global_position
	$SpecialAttacks.add_child(cursed_orb_instance)
	$Monster/CursedOrbCooldown.wait_time = randi_range(4,5)
