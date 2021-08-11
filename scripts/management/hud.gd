extends CanvasLayer
class_name GUI

signal start_level
signal change_level

onready var h_container: HBoxContainer = get_node("Interface/HBoxContainer")
onready var health_gui: TextureRect = h_container.get_node("VBoxLife/HealthGUI")
onready var v_box_score: VBoxContainer = h_container.get_node("VBoxScore")
onready var score_gui: Label = v_box_score.get_node("DiamondGUI/Score")
onready var animation: AnimationPlayer = get_node("Animation")

export(Array, String) var health_texture

func _ready() -> void:
	Globals.load_data()
	update_gui(Globals.data_dictionary.health, "Support")
	update_gui(Globals.data_dictionary.money, "Extra")
	
	
func start_game() -> void:
	h_container.visible = true
	emit_signal("start_level")
	
	
func fade_in_animation() -> void:
	animation.play("fade_in")
	
	
func change_level() -> void:
	emit_signal("change_level")
	
	
func update_gui(value: int, type: String) -> void:
	match type:
		"Attack":
			health_gui.texture = load(health_texture[value])
			
		"Support":
			health_gui.texture = load(health_texture[value])
			
		"Extra":
			score_gui.text = str(value)
