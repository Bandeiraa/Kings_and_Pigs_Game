extends Area2D
class_name HitBox

const DAMAGE_POPUP: Resource = preload("res://scenes/combat/damage_popup.tscn")

export(int) var health

func on_body_entered(_body: Object) -> void:
	pass
	
	
func on_area_entered(_area: Object) -> void:
	pass
	
	
func instance_popup(amount: int, type: String) -> void:
	var instanced_popup = DAMAGE_POPUP.instance()
	instanced_popup.value = amount
	instanced_popup.type = type
	instanced_popup.position = global_position
	get_tree().root.call_deferred("add_child", instanced_popup)
