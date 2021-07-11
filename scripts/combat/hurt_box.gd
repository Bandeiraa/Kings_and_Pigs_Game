extends Area2D
class_name Hurtbox

export(float) var damage
export(Vector2) var hurtbox_position

func verify_direction(input_vector: int) -> void:
	if sign(input_vector) == 1:
		position = hurtbox_position
		scale = Vector2(1, 1)
	elif sign(input_vector) == -1:
		position = Vector2(-hurtbox_position.x, hurtbox_position.y)
		scale = Vector2(-1, 1)
