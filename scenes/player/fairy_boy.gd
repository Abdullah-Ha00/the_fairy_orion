extends CharacterBody2D
var fairy_position: Vector2 = Vector2.ZERO
var speed: int =300
var is_moving = true
var can_cast_sword_beam = true
signal sword_beam(pos)
var is_enemy = false
var is_ally = true
var _health = 100
var health = _health:
	set(value):
		health = clamp(value, 0, _health)
var _magic = 50
var magic = _magic:
	set(value):
		magic = clamp(value, 0,_magic)
var magic_regen = 5
var beam_magic_cost = 5

func _ready() -> void:
	fairy_position = Vector2(200,400)
	position = fairy_position
	$SwordLight.visible = false
	$UI/HealthBar.max_value = health
	$UI/MagicBar.max_value = magic
	update_health_text()
	update_magic_text()
	
func _process(_delta: float) -> void:
	var fairy_direction: Vector2= Input.get_vector("left","right","up","down")
	if is_moving:
		velocity =fairy_direction*speed
		move_and_slide()
	if Input.is_action_pressed("attach action") and can_cast_sword_beam and magic >=beam_magic_cost: 
		var sword_markers = $SwordMarkers.get_children()
		var selected_sword_marker = sword_markers[randi() % sword_markers.size()]
		$CastSwordBeamTimer.start()
		can_cast_sword_beam = false
		sword_beam.emit(selected_sword_marker.global_position)
		$AnimationPlayer.play("sword_light")
		magic -= beam_magic_cost
		update_magic_text()
	GlobalFunctions.fairy_health = health

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
	update_magic_text()
