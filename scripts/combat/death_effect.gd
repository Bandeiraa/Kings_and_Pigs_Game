extends AnimatedSprite

func _ready() -> void:
	play("Death")


func on_animation_finished() -> void:
	queue_free()
