extends CharacterBody2D
const speed = 100
var parrot_position:Vector2= Vector2.ZERO
var is_enemy = false
var is_ally = true
var _health = 20
var health = _health:
	set(value):
		health = clamp(value, 0, _health)
@onready var seconds_left = int($TimeLeft.time_left)


func _ready() -> void:
	parrot_position = Vector2(940,66)
	position = parrot_position 
	$HealthUI/HealthBar.max_value = health
	$TimerUI/TimeBar.max_value = seconds_left
	$TimerUI/SecondsLeft.text = str(seconds_left)
	update_health_text()
	

func _process(_delta: float) -> void:
	update_parrot_timer()
	GlobalFunctions.parrot_health = health

func _on_time_left_timeout() -> void:
	health = 0
	update_health_text()
func update_parrot_timer():
	seconds_left = round($TimeLeft.time_left)
	$TimerUI/SecondsLeft.text = str(seconds_left)
	$TimerUI/TimeBar.value = seconds_left

func update_health_text():
		$HealthUI/HealthNumber.text = str(health)
		$HealthUI/HealthBar.value = health
	
