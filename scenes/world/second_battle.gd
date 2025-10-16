extends MainScene
var magic_bug_scene:PackedScene = preload("res://scenes/monster/bug.tscn")
var health_bug_scene: PackedScene = preload("res://scenes/monster/bug_health.tscn")
var damage_bug_scene: PackedScene = preload("res://scenes/monster/bug_damage.tscn")
var bug_scenes:Array = [magic_bug_scene, health_bug_scene, damage_bug_scene]

func _on_summon_bugs_timeout() -> void:
	var bug_instance = bug_scenes[randi() % bug_scenes.size()].instantiate()
	set_bug_random_position(bug_instance)
	self.add_child(bug_instance)
	$Timers/SummonBugs.wait_time = randi_range(5,7)

func set_bug_random_position(bug_instance):
	var positions:Array = $Fence/BugsSpawnPositions.get_children()
	var summon_position:Vector2 = positions[randi() % positions.size()].global_position
	set_summon_light(summon_position)
	bug_instance.position = summon_position

func set_summon_light(pos:Vector2):
	$SummonLight.position = pos
	$AnimationPlayer.play("bug_summon_light")
	$Audio/Sfx/SummonBug.play()
