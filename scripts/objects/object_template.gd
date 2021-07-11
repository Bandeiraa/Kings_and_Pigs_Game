extends RigidBody2D
class_name ObjectTemplate

onready var collision: CollisionShape2D = get_node("Collision")
onready var anim_sprite: AnimatedSprite = get_node("Texture")

export(String) var type
export(float) var spawn_rate 
export(float) var x_threshold
export(float) var y_threshold

func _ready() -> void:
	apply_impulse(Vector2.ZERO, random_value())
	
	
func random_value() -> Vector2:
	randomize()
	return Vector2(
		rand_range(-x_threshold, x_threshold), 
		rand_range(-x_threshold, -y_threshold)
	)
	
	
func on_body_entered(_body: Object) -> void:
	pass 
	
	
func on_area_entered(_area: Object) -> void:
	pass 
