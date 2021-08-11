extends PhysicsBody2D
class_name EnemyManager

const DEATH_FX: Resource = preload("res://scenes/combat/death_effect.tscn")

var player_ref: Object = null
var initial_modulate: Color

onready var timer: Timer = get_node("Timer")
onready var tween: Tween = get_node("Tween")
onready var animation: AnimationPlayer = get_node("Animation")
onready var detection_area: Area2D = get_node("DetectionArea")

export(Color) var hit_color = "9bffffff"
export(float) var attack_cooldown

func _ready() -> void:
	initial_modulate = modulate
	timer.set_wait_time(attack_cooldown)
	
	
func has_sight() -> bool:
	if player_ref != null:
		var space_state: Physics2DDirectSpaceState = get_world_2d().direct_space_state
		var sight_check: Dictionary = space_state.intersect_ray(
			position, 
			player_ref.position, 
			[self], 
			collision_mask
		)
		
		if sight_check.collider.name == "King":
			return true
		else:
			return false
			
	else:
		return false
			
			
func kill():
	var instanced_fx: Object = DEATH_FX.instance()
	get_tree().root.call_deferred("add_child", instanced_fx)
	instanced_fx.global_position = get_node("HitBox").global_position
	queue_free()
	
	
func animate() -> void:
	var _interpolate_from: bool = tween.interpolate_property(
		self,
		'modulate', 
		modulate, 
		hit_color, 
		.1, 
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT
	)
	
	var _interpolate_to: bool = tween.interpolate_property(
		self,
		'modulate',
		hit_color,
		initial_modulate,
		.3,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT
	)
	
	var _start_tween: bool = tween.start()
