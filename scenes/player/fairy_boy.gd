extends CharacterBody2D
var speed:int = 300
var is_moving:bool = true
var can_cast_sword_beam:bool = true
var is_enemy:bool = false
var is_ally:bool = true
var _health:int = 100
var health:int = _health:
	set(value):
		health = clamp(value, 0, _health)
var _magic:int = 50
var magic:int = _magic:
	set(value):
		magic = clamp(value, 0,_magic)
var magic_regen:int = 5
var beam_magic_cost:int = 5
signal sword_beam(pos)

func _ready() -> void:
	position = Vector2(200,400)
	$SwordLight.hide()
	set_up_stats_bars()
	initialize_fairy_node()
	update_health_text()
	update_magic_text()
	
func _process(_delta: float) -> void:
	update_fairy_movements()
	check_sword_beam_event()
	
func _on_shock_timer_timeout() -> void:
	is_moving= true 
	can_cast_sword_beam = true
	
func _on_cast_sword_beam_timer_timeout() -> void:
	can_cast_sword_beam= true 
	
func update_health_text():
		$UI/HealthNumber.text = str(health)
		$UI/HealthBar.value = health
		
func update_magic_text():
		$UI/MagicNumber.text = str(magic)
		$UI/MagicBar.value = magic

func _on_magic_regen_timer_timeout() -> void:
	magic+=magic_regen
	change_color_on_regen(self)
	update_magic_text()
	
func set_up_stats_bars():
	$UI/HealthBar.max_value = health
	$UI/MagicBar.max_value = magic

func initialize_fairy_node():
	GlobalStats.fairy_node = self
	
func update_fairy_movements():
	var fairy_direction: Vector2= Input.get_vector("left","right","up","down")
	if is_moving:
		velocity =fairy_direction*speed
		move_and_slide()

func check_sword_beam_event():
	if Input.is_action_pressed("attach action") and can_cast_sword_beam and magic >=beam_magic_cost: 
		emit_sword_beam()
		magic -= beam_magic_cost
		update_magic_text()
#
func emit_sword_beam():
		$Timers/BeamTimer.start()
		can_cast_sword_beam = false
		sword_beam.emit($BeamMarker.global_position)
		$AnimationPlayer.play("sword_light")

func change_color_on_regen(body:Node):
	if body.health>0:
		body.modulate = Color.ROYAL_BLUE
		await get_tree().create_timer(0.5).timeout
		body.modulate= body.self_modulate
