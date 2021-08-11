extends ObjectTemplate

export(PackedScene) var explosion_effect 
export(int) var damage

func _ready() -> void:
	apply_impulse(Vector2.ZERO, Vector2(-350, -10))
	
	
func on_area_entered(area: Object) -> void:
	area.update_health(damage, type)
	instance_object()
	
	
func on_body_entered(_body: Object) -> void:
	instance_object()
	
	
func instance_object() -> void:
	var object_to_spawn = explosion_effect.instance()
	object_to_spawn.global_position = global_position
	get_tree().root.call_deferred("add_child", object_to_spawn)
	queue_free()
