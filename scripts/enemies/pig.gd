extends EnemyManager

onready var texture: Sprite = get_node("Texture")
onready var spawner: Position2D = get_node("Spawner")

export(String) var state
export(float) var box_direction

func _physics_process(_delta: float) -> void:
	match state:
		"Idle":
			animation.play("Idle_Box")
			if player_ref != null and has_sight():
				state = "Throw"
				
		"Throw":
			detection_area.monitoring = true
			animation.play("Throw_Box")
			if player_ref != null and has_sight():
				var player_position: Vector2 = (player_ref.global_position - global_position).normalized()
				texture.verify_position(player_position.x)
			else:
				state = "Idle"
				
		"Pick":
			texture.verify_position(box_direction)
			animation.play("Pick_Box")
			
		"Default":
			animation.play("Idle")
			
			
func on_body_entered(body: Object) -> void:
	player_ref = body
	spawner.get_player_info(player_ref)
		
		
func on_body_exited(_body) -> void:
	player_ref = null
	spawner.get_player_info(player_ref)
	
	
func is_attacking() -> void:
	detection_area.set_deferred("monitoring", false)
	state = "Default"
	timer.start()
	
	
func on_timer_timeout() -> void:
	state = "Pick"
