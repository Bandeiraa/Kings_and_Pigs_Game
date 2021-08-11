extends AnimatedSprite

func _ready() -> void:
	play("Explosion")
	
	
func on_animation_finished() -> void:
	queue_free()
