extends CharacterBody2D
class_name Monster
var speed: int = 200
var orb_cooldown:float = randi_range(1,3)
var movement:Array = [Vector2.UP, Vector2.DOWN, Vector2.RIGHT, Vector2.LEFT]
var direction:Vector2= movement[randi() % movement.size()]
var _health:int = 200
var health:int = _health:
	set(value):
		health=clamp(value,0,_health)
		$Audio/HitSfx.play()
var half_health:float = health / 2.0
var process:bool = true
signal black_orb(pos)

func _ready() -> void:
	position = Vector2(1200,500)
	$OrbLight.visible = false
	initialize_monster_node()
	set_direction()
	set_up_orb_cooldown()
	set_up_stats_bars()
	update_health_text()

func _process(_delta: float) -> void:
	move_and_slide()
	check_monster_health()
		
func _orb_cool_down_timeout() -> void:
	emit_orb()
	
func _on_change_direction_timeout() -> void:
	direction = movement[randi() % movement.size()]
	velocity = direction*speed
	move_and_slide()
	
func update_health_text():
		$UI/HealthNumber.text = str(health)
		$UI/HealthBar.value = health
		
func initialize_monster_node():
	GlobalStats.monster_node = self

func set_up_orb_cooldown():
	$Timers/OrbCoolDown.wait_time = orb_cooldown
	$Timers/OrbCoolDown.start()

func set_direction():
	velocity = direction *speed
	$Timers/ChangeDirection.start()

func set_up_stats_bars():
	$UI/HealthBar.max_value = health

func emit_orb():
	orb_cooldown = randi_range(1,3)
	black_orb.emit( $OrbMarker.global_position)
	$Timers/OrbCoolDown.wait_time= orb_cooldown
	$AnimationPlayer.play("orb_light")
	
func check_monster_health():
	if health <=int(half_health) and process:
		GlobalStats.current_game_phase = GlobalStats.game_phases["monster_health_halved"]
		process = false
