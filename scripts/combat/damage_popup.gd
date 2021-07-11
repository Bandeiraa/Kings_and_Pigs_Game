extends Position2D
class_name DamagePopup

onready var damage_label: Label = get_node("Label")
onready var tween: Tween = get_node("Tween")

var value: int = 0
var type: String = ""
var velocity: Vector2 = Vector2.ZERO

export(Vector2) var max_scale_size
export(Vector2) var min_scale_size

func _ready() -> void:
	match type:
		"Damage":
			damage_label.add_color_override("font_color", Color(0.91, 0.08, 0.08, 1.0))
			
		"Heal":
			damage_label.add_color_override("font_color", Color(0.84, 0.07, 0.07, 1.0))
			
	damage_label.text = str(value)
	randomize()
	var label_movement: float = rand_range(-10, 10)
	velocity = Vector2(label_movement, -10)
	var _interpolate_from: bool = tween.interpolate_property(
		self,
		'scale', 
		scale, 
		max_scale_size, 
		.2, 
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT
	)
	
	var _interpolate_to: bool = tween.interpolate_property(
		self,
		'scale',
		max_scale_size,
		min_scale_size,
		.7,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT,
		.3
	)
	
	var _start_tween: bool = tween.start()
	
	
func _physics_process(delta: float) -> void:
	position += velocity * delta
	
	
func on_tween_completed() -> void:
	queue_free()
