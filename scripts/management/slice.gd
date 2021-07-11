extends RigidBody2D

func _ready():
	randomize()
	apply_impulse(Vector2.ZERO, Vector2(rand_range(-30, 30), rand_range(-50, -75)))
	
	
func on_screen_exited() -> void:
	queue_free()
