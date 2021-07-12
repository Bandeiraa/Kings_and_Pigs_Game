extends ObjectTemplate

export(int) var value

func on_area_entered(area: Object) -> void:
	collision_area.queue_free()
	area.update_money(value, type)
	anim_sprite.play("Hit")
		
		
func on_animation_finished() -> void:
	if anim_sprite.animation == "Hit":
		queue_free()
