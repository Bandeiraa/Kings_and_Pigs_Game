extends Sprite
class_name PigTexture

func verify_position(distance: float):
	if sign(distance) == 1:
		set_flip_h(true)
	elif sign(distance) == -1:
		set_flip_h(false)
