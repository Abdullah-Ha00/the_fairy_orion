extends MainScene
var magic_bug_scene:PackedScene = preload("res://scenes/monster/bug.tscn")
var health_bug_scene: PackedScene = preload("res://scenes/monster/bug_health.tscn")
var damage_bug_scene: PackedScene = preload("res://scenes/monster/bug_damage.tscn")
var cursed_orb_scene: PackedScene = preload("res://scenes/special_attacks/cursed_orb.tscn")
var ray_scene: PackedScene = preload("res://scenes/special_attacks/ray.tscn")
var bug_scenes:Array = [magic_bug_scene, health_bug_scene, damage_bug_scene]

func _ready() -> void:
	level_key = "0-2"
	super()
	
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
	$Lights/SummonLight.position = pos
	$AnimationPlayer.play("bug_summon_light")
	$Audio/Sfx/SummonBug.play()

func _on_move_parrot_timeout() -> void:
	if is_instance_valid(GlobalStats.parrot_node) and is_instance_valid(GlobalStats.fairy_node):
		$Audio/Sfx/MoveParrot.play()
		$Parrot.y_pos =$Fairy.position.y - 100
		$Timers/MoveParrot.wait_time = randi_range(4,7)


func _on_monster_cursed_orb() -> void:
	var cursed_orb_instance = cursed_orb_scene.instantiate()
	cursed_orb_instance.position = $Monster/CursedOrb.global_position
	$SpecialAttacks.add_child(cursed_orb_instance)
	
	
func _on_fairy_ray() -> void:
	if $Fairy.monster_in_range:
		instantiate_ray()
		$Fairy.ray_debuff()

func instantiate_ray():
	var ray_instance = ray_scene.instantiate()
	ray_instance.position = $Fairy/Marker2D.position + Vector2(460, -30)
	$Fairy.add_child(ray_instance)
