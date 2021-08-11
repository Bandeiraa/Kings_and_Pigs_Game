extends HitBox

signal hit_animation

var money: int = 0

func _ready() -> void:
	Globals.load_data()
	update_health(Globals.data_dictionary.health, "Support")
	update_money(Globals.data_dictionary.money, "Extra")
	
	
func update_health(value: int, type: String) -> void:
	match type:
		"Attack":
			health -= value
			send_animation()
			
		"Support":
			health += value
			verify_health()
			
	if get_parent().visible == true:
		instance_popup(value, type)
		
	get_tree().call_group("Interface", "update_gui", health, type)
			
			
func update_money(value: int, type: String) -> void:
	money += value
	get_tree().call_group("Interface", "update_gui", money, type)
	
	
func send_animation() -> void:
	if health > 0:
		emit_signal("hit_animation", "Hit")
	else:
		emit_signal("hit_animation", "Dead")
		
		
func verify_health() -> void:
	if health > 6:
		health = 6
