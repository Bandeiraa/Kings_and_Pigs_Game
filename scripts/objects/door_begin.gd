extends DoorManager

signal load_player

func door_opening() -> void:
	texture.play("door_opening")
	
	
func on_body_entered(_body: Object) -> void:
	pass
	
	
func on_body_exited(_body: Object) -> void:
	pass
	
	
func on_animation_finished() -> void:
	if texture.animation == "door_opening":
		emit_signal("load_player")
