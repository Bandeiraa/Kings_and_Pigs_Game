extends Sprite
class_name KingPlayerTexture

signal attack_end

onready var animation: AnimationPlayer = get_node("Animation")

export(bool) var on_hit

func animation_manager(input_vector: Vector2, jumping: bool, attacking: bool) -> void:
	verify_direction(input_vector.x)
	if jumping and not on_hit:
		jump_animation(input_vector.y)
		
	if attacking and not jumping:
		animation.play("Attack")
		
	if not jumping and not attacking and not on_hit:
		move_animation(input_vector.x)
		
		
func verify_direction(x_velocity: float) -> void:
	if x_velocity > 0:
		set_flip_h(false)
	elif x_velocity < 0:
		set_flip_h(true)
		
		
func jump_animation(y_velocity: float) -> void:
	if y_velocity > 0:
		animation.play("Fall")
	elif y_velocity < 0:
		animation.play("Jump")
		
		
func move_animation(x_velocity: float) -> void:
	if x_velocity != 0:
		animation.play("Run")
	elif x_velocity == 0:
		animation.play("Idle")
		
		
func hit_animation(animation_name: String) -> void:
	on_hit = true
	emit_signal("attack_end")
	animation.play(animation_name)
