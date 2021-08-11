extends EnemyAttackSpawner

signal is_attacking

var player_ref: Object = null

func get_player_info(player: Object) -> void:
	player_ref = player
	
	
func instance_object() -> void:
	var instanced_box = object_to_spawn.instance()
	instanced_box.position = global_position
	instanced_box.apply_impulse(Vector2.ZERO, calculate_forces()) 
	get_tree().root.call_deferred("add_child", instanced_box)
	emit_signal("is_attacking")
	
	
func calculate_forces() -> Vector2:
	var player_distance: Vector2 = player_ref.global_position - global_position
	var player_force: float = player_distance.length()
	var velocity_vector: Vector2 = player_distance.normalized() * (player_force * .9)
	var force: float = velocity_vector.length()
	var angle: float = velocity_vector.angle()
	var x_velocity: float = (PI * cos(angle) * force)
	var y_velocity: float = (PI * sin(angle) * force)
	return Vector2(x_velocity, y_velocity)
