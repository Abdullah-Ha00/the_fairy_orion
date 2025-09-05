extends CharacterBody2D
var speed: int = 200
var orb_cooldown_start:float = randi_range(1,3)
signal black_orb(pos)
var move_up = Vector2.UP
var move_down =Vector2.DOWN
var move_right = Vector2.RIGHT
var move_left = Vector2.LEFT
var movement = [move_up, move_down, move_right, move_left]
var direction = movement[randi() % movement.size()]
var is_enemy=true
var is_ally =false
var _health = 200
var health:int = _health:
	set(value):
		health=clamp(value,0,_health)
var half_health:float = health / 2.0

func _ready() -> void:
	GlobalFunctions.monster_half_health = int(half_health)
	GlobalFunctions.monster_health = health
	GlobalFunctions.is_monster_half_health = false
	position = Vector2(1200,500)
	$OrbCoolDown.wait_time = orb_cooldown_start
	$OrbCoolDown.start()
	#print("Start Orb Cooldown: %.1f seconds" %orb_cooldown_start)
	velocity = direction *speed
	$ChangeDirection.start()
	$OrbLight.visible = false
	$HealthBar.max_value = health
	update_health_text()

func _process(_delta: float) -> void:
	GlobalFunctions.monster_health = health
	move_and_slide()
	
func _orb_cool_down_timeout() -> void:
	var orb_cooldown_time = randi_range(1,3)
	var orb_marker_position = $OrbMarker.global_position
	black_orb.emit(orb_marker_position)
	#print("Dynamic Cooldown: %.1f seconds"%$OrbCoolDown.wait_time)
	$OrbCoolDown.wait_time= orb_cooldown_time 
	$AnimationPlayer.play("orb_light")


func _on_change_direction_timeout() -> void:
	direction = movement[randi() % movement.size()]
	velocity = direction*speed
	move_and_slide()
	
func update_health_text():
		$HealthNumber.text = str(health)
		$HealthBar.value = health
	
