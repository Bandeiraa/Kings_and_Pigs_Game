extends ObjectTemplate

export(int) var heal

func on_body_entered(body: Object) -> void:
	if body.is_in_group("King"):
		anim_sprite.play("Hit")
		collision.queue_free()
		
		
func on_animation_finished() -> void:
	if anim_sprite.animation == "Hit":
		queue_free()
