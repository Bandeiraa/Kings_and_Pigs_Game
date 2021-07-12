extends KinematicBody2D
class_name Pig

const BOX: Resource = preload("res://scenes/objects/damage_box.tscn")

var player_ref: Object = null

onready var animation: AnimationPlayer = get_node("Animation")
onready var detection_area: Area2D = get_node("DetectionArea")
onready var texture: Sprite = get_node("Texture")
onready var timer: Timer = get_node("Timer")

export(String) var state
export(float) var attack_cooldown
export(float) var box_direction

func _ready() -> void:
	timer.set_wait_time(attack_cooldown)
	
	
func _physics_process(_delta: float) -> void:
	match state:
		"Idle":
			animation.play("Idle_Box")
			if player_ref != null:
				state = "Throw"
				
		"Throw":
			animation.play("Throw_Box")
			if player_ref != null:
				var player_position: Vector2 = (player_ref.global_position - global_position).normalized()
				texture.verify_position(player_position.x)
			else:
				state = "Idle"
				
		"Pick":
			texture.verify_position(box_direction)
			animation.play("Pick_Box")
			
		"Default":
			animation.play("Idle")
			
			
func instance_object() -> void:
	var instanced_box = BOX.instance()
	instanced_box.position = global_position
	instanced_box.apply_impulse(Vector2.ZERO, calculate_forces()) 
	get_tree().root.call_deferred("add_child", instanced_box)
	detection_area.set_deferred("monitorable", false)
	state = "Default"
	timer.start()
	
	
func calculate_forces() -> Vector2:
	var player_distance: Vector2 = player_ref.global_position - global_position
	var player_force: float = player_distance.length()
	var velocity_vector: Vector2 = player_distance.normalized() * (player_force * calculate_scale_foce(player_force))
	var force: float = velocity_vector.length()
	var angle: float = velocity_vector.angle()
	var x_velocity: float = (PI * cos(angle) * force)
	return Vector2(x_velocity, calculate_y_value(player_distance.y, angle, force))
	
	
func calculate_scale_foce(player_force: float) -> float:
	if player_force < 70:
		return 0.45
	elif player_force > 70:
		return 0.3
	else:
		return 0.0
		
		
func calculate_y_value(y_distance: float, angle: float, force: float) -> float:
	if y_distance > 0:
		return -(PI * sin(angle) * force)
	elif y_distance < 0:
		return (PI * sin(angle) * force)
	else:
		return 0.0
		
		
func on_body_entered(body: Object) -> void:
	if body.is_in_group("King"):
		player_ref = body
		
		
func on_body_exited(_body) -> void:
	player_ref = null
	
	
func on_timer_timeout() -> void:
	state = "Pick"
