extends CharacterBody2D
var is_enemy:bool= false
var is_ally:bool = true
var states:Array = ["normal", "hit"]
var current_state:String
var current_health:int
var process:bool = true
var _health:int = 20
var health:int = _health:
	set(value):
		health = clamp(value, 0, _health)
		$Audio/HitSfx.play()
@onready var seconds_left:float = int($Timers/TimeLeft.time_left)
@onready var high_tick_wait_time:float = seconds_left* 3/4

func _ready() -> void:
	position = Vector2(1020,50)
	initialize_high_tick_timer()
	initialize_parrot_node()
	set_up_stats_bars()
	initialize_stats()
	update_parrot_timer()
	update_health_text()
	
func _process(_delta: float) -> void:
	update_parrot_timer()
	check_parrot_health()
	
func _on_time_left_timeout() -> void:
	health = 0
	update_health_text()
	
func update_parrot_timer():
	seconds_left = round($Timers/TimeLeft.time_left)
	$TimerUI/SecondsLeft.text = str(seconds_left)
	$TimerUI/TimeBar.value = seconds_left

func update_health_text():
		$HealthUI/HealthNumber.text = str(health)
		$HealthUI/HealthBar.value = health

func set_up_stats_bars():
	$HealthUI/HealthBar.max_value = health
	$TimerUI/TimeBar.max_value = seconds_left

func initialize_stats():
	current_health = health
	current_state = states[0]
	
func initialize_parrot_node():
	GlobalStats.parrot_node = self

func check_parrot_health():
	if current_health !=health and process:
		current_state = states[1]
		process =false
		
func initialize_high_tick_timer():
	$Timers/HighTick.wait_time = high_tick_wait_time
	$Timers/HighTick.start()

func _on_tick_timeout() -> void:
	$Audio/TickSfx.play(1.1)

func _on_high_tick_timeout() -> void:
	$Audio/TickSfx.volume_db = 20
