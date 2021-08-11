extends DoorManager

signal fade_in

var can_change_scene: bool = false
var player_ref: Object = null

export(String) var next_level_path

func _process(_delta: float) -> void:
	if player_ref != null:
		if player_ref.visible == false:
			texture.play("door_closing")
			can_change_scene = true
			
	if can_change_scene:
		emit_signal("fade_in")
		can_change_scene = false
		
		
func on_body_entered(body: Object) -> void:
	body.door_ref = self
	player_ref = body
	texture.play("door_opening")
	
	
func on_body_exited(body: Object) -> void:
	body.door_ref = null
	player_ref = null
	texture.play("door_closing")
	
	
func on_animation_finished() -> void:
	pass
