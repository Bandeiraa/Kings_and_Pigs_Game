extends ObjectTemplate

export(PackedScene) var slices_to_spawn 
export(Array, PackedScene) var assistants_list 

func on_area_entered(_area: Object) -> void: 
	instance_spawner()
	instance_assistant() 
			
			
func instance_spawner() -> void: 
	var object = slices_to_spawn.instance()
	object.global_position = global_position
	get_tree().root.call_deferred("add_child", object)
	queue_free()
	
	
func instance_assistant() -> void: 
	var list_size: int = assistants_list.size()
	for index in list_size:
		var item: RigidBody2D = assistants_list[index].instance()
		var spawn_rate: float = item.spawn_rate
		var random_value: int = randi() % 101
		if random_value < spawn_rate:
			item.global_position = global_position
			get_tree().root.call_deferred("add_child", item)
