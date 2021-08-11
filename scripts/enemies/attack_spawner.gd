extends Position2D
class_name EnemyAttackSpawner

export(PackedScene) var object_to_spawn

func instance_object() -> void:
	var instanced_object = object_to_spawn.instance()
	instanced_object.global_position = global_position
	get_tree().root.call_deferred("add_child", instanced_object)
