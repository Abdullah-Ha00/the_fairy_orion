extends Monster
var in_range:bool = false
signal cursed_orb

func _ready() -> void:
	super()
	$CursedOrb.visible =false

	
func emit_orb():
	if in_range:
		super()

func _on_attack_range_body_entered(_body: Node2D) -> void:	
	in_range = true

func _on_attack_range_body_exited(_body: Node2D) -> void:
	in_range = false


func _on_cursed_orb_cooldown_timeout() -> void:
	if GlobalStats.current_game_phase == GlobalStats.game_phases["monster_health_halved"]:
		cursed_orb.emit()

func check_monster_health():
	if health <=int(half_health) and process:
		GlobalStats.current_game_phase = GlobalStats.game_phases["monster_health_halved"]
		$CursedOrbAnimation.play("orb_charge")
		$CursedOrbCooldown.start()
		process = false
		
func set_cursed_orb_position():
	var cursed_orb_position = $CursedOrbSpawnPositions.get_children().pick_random().global_position
	$CursedOrb.global_position = cursed_orb_position
	
