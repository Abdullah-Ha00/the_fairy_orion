extends Fairy
var monster_in_range:bool = false
var ray_health_cost: int = 20
var ray_used:bool = false
var ray_available:bool = false
signal ray

func _ready() -> void:
	super()
	initialize_ray_sprite()
	
func _process(delta: float) -> void:
	super(delta)
	disable_ray()
	
func _on_ray_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Monster") and ray_available:
		monster_in_range = true
		$RayRange/RaySprite.modulate = Color.WHITE
		play_ray_area_sound()
		
func _on_ray_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("Monster") and ray_available:
		monster_in_range = false
		$RayRange/RaySprite.modulate = Color.RED
		play_ray_area_sound()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ray_attack") and health>ray_health_cost:
		ray_used = true
		ray.emit()
		
func ray_debuff():
	$RayRange.queue_free()
	health -= ray_health_cost
	update_health_text()
	GlobalFunctions.change_color_on_hit(GlobalStats.fairy_node, Color.DARK_MAGENTA)

func play_ray_area_sound():
	if monster_in_range and not ray_used:
		$RayRangeSFX/RayRangeEntered.play()
	elif not monster_in_range and not ray_used:
		$RayRangeSFX/RayRangeExited.play()

func initialize_ray_sprite():
	$RayRange/RaySprite.visible = false
	$RayRange/RaySprite.modulate = Color.RED

func disable_ray():
	if health <= ray_health_cost and not ray_used:
		ray_available= false
		$RayRange/RaySprite.visible = false
