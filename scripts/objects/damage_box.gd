extends ObjectTemplate

export(PackedScene) var slices_to_spawn 
export(int) var damage 

func on_area_entered(area: Object) -> void:
	if area.is_in_group("HurtBox"):
		instance_spawner()
		return
		
	area.update_health(damage, type)
	instance_spawner() 
	
	
func on_body_entered(_body: Object) -> void:
	instance_spawner()
	
	
func instance_spawner() -> void: 
	var object = slices_to_spawn.instance()
	object.global_position = global_position
	get_tree().root.call_deferred("add_child", object)
	queue_free()
