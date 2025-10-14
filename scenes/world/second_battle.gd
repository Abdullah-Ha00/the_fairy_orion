extends MainScene
var bug_scene:PackedScene = preload("res://scenes/monster/bug.tscn")


func _on_summon_bugs_timeout() -> void:
	var bug_instance = bug_scene.instantiate()
	set_bug_random_position(bug_instance)
	self.add_child(bug_instance)
	$Timers/SummonBugs.wait_time = randi_range(5,7)

func set_bug_random_position(bug_instance):
	var positions:Array = $Fence/BugsSpawnPositions.get_children()
	bug_instance.position = positions[randi() % positions.size()].global_position
