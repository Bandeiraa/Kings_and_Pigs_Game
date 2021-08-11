extends KinematicBody2D
class_name KingPlayer

onready var texture: Sprite = get_node("Texture")
onready var hurtbox: Area2D = get_node("HurtBox")

var door_ref: Object = null
var velocity: Vector2 = Vector2.ZERO
var input_strength: Vector2 = Vector2.ZERO

var jump_count: int = 0
var is_jumping: bool = false
var is_interacting: bool = false
var is_attacking: bool = false

export(int) var speed 
export(int) var jump_speed
export(int) var gravity

export(float, 0, 1.0) var acceleration = 0.25

func _ready() -> void:
	set_physics_process(false)
	
	
func _physics_process(delta: float) -> void:
	input_listener()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP, false, 4, PI/4, false)
	texture.animation_manager(velocity, is_jumping, is_attacking, is_interacting)
	hurtbox.verify_direction(velocity.x)
	
	
func input_listener() -> void:
	move()
	jump()
	attack()
	interact()
	
	
func move() -> void:
	input_strength = Vector2.ZERO
	input_strength.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	if input_strength.x != 0:
		velocity.x = lerp(velocity.x, input_strength.x * speed, acceleration) 
	else:
		velocity.x = 0
		
		
func jump() -> void:
	if is_on_floor():
		is_jumping = false
		jump_count = 0
		
	if Input.is_action_just_pressed("Jump") and jump_count < 2:
		is_jumping = true
		velocity.y = jump_speed
		jump_count += 1
		
		
func attack() -> void:
	if Input.is_action_just_pressed("Attack") and not is_jumping:
		is_attacking = true
		set_physics_process(false)
		
		
func interact() -> void:
	if Input.is_action_just_pressed("Interact") and door_ref != null:
		is_interacting = true
		set_physics_process(false)
		
		
func attack_end() -> void:
	hurtbox.get_node("CollisionShape2D").set_deferred("disabled", true)
	is_attacking = false
	set_physics_process(true)
