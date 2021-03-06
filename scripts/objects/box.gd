extends ObjectTemplate

export(PackedScene) var slices_to_spawn #Both Boxes

export(int) var damage #Damage Box

func on_body_entered(body: Object) -> void: #Damage Box
	instance_spawner() 
				
				
export(Array, PackedScene) var assistants_list #Support Box
func on_area_entered(area: Object) -> void: #Support Box
	instance_spawner()
	instance_assistant() 
			
			
func instance_spawner() -> void: #Both Boxes
	var object = slices_to_spawn.instance()
	object.global_position = global_position
	get_tree().root.call_deferred("add_child", object)
	queue_free()
	
	
func instance_assistant() -> void: #Support Box
	var list_size: int = assistants_list.size()
	for index in list_size:
		var item: RigidBody2D = assistants_list[index].instance()
		var spawn_rate: float = item.spawn_rate
		var random_value: int = randi() % 101
		if random_value < spawn_rate:
			item.global_position = global_position
			get_tree().root.call_deferred("add_child", item)
