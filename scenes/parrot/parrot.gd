extends CharacterBody2D
var is_enemy = false
var is_ally = true
var states:Array = ["normal", "hit"]
var current_state:String
var current_health:int
var process = true
var _health = 20
var health = _health:
	set(value):
		health = clamp(value, 0, _health)
@onready var seconds_left = int($TimeLeft.time_left)


func _ready() -> void:
	#GlobalFunctions.is_parrot_already_hit = true
	#GlobalFunctions.is_parrot_hit = false
	GlobalStats.parrot_node = self
	current_health = health
	current_state = states[0]
	position = Vector2(940,66)
	$HealthUI/HealthBar.max_value = health
	$TimerUI/TimeBar.max_value = seconds_left
	$TimerUI/SecondsLeft.text = str(seconds_left)
	update_health_text()
	

func _process(_delta: float) -> void:
	update_parrot_timer()
	
	if current_health !=health and  process:
		current_state = states[1]
		print(current_state)
		process =false
		

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
	
