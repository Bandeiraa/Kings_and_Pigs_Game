extends Area2D

signal hit_animation

const DAMAGE_POPUP: Resource = preload("res://scenes/combat/damage_popup.tscn")

var money: int = 0

export(int) var health

func on_body_entered(body: Object) -> void:
	match body.type:
		"Damage":
			instance_popup(body.damage, body.type)
			health -= body.damage
			get_tree().call_group("Interface", "update_gui", health, body.type)
			if health > 0:
				emit_signal("hit_animation", "Hit")
			else:
				emit_signal("hit_animation", "Dead")
				
		"Support":
			if body.is_in_group("Assistant"):
				instance_popup(body.heal, body.type)
				health += body.heal
				if health > 6:
					health = 6
					
				get_tree().call_group("Interface", "update_gui", health, body.type)
				
		"Extra":
			if body.is_in_group("Assistant"):
				money += body.value
				get_tree().call_group("Interface", "update_gui", money, body.type)
					
					
func instance_popup(amount: int, type: String) -> void:
	var instanced_popup = DAMAGE_POPUP.instance()
	instanced_popup.value = amount
	instanced_popup.type = type
	instanced_popup.position = global_position
	get_tree().root.call_deferred("add_child", instanced_popup)
