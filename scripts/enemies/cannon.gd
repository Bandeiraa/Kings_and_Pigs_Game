extends EnemyManager

export(String) var state

func _physics_process(_delta: float) -> void:
	match state:
		"Idle":
			animation.play("Idle")
			if player_ref != null and has_sight():
				state = "Shoot"
			
		"Shoot":
			animation.play("Shoot")
			
			
func on_body_entered(body: Object) -> void:
	player_ref = body
	
	
func on_body_exited(_body) -> void:
	player_ref = null
	
	
func start_countdown() -> void:
	detection_area.set_deferred("monitoring", false)
	state = "Idle"
	timer.start()
	
	
func on_timer_timeout() -> void:
	detection_area.monitoring = true
