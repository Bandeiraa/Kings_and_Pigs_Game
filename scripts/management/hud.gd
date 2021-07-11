extends CanvasLayer
class_name GUI

onready var h_container: HBoxContainer = get_node("Interface/HBoxContainer")
onready var health_gui: TextureRect = h_container.get_node("VBoxLife/HealthGUI")
onready var v_box_score: VBoxContainer = h_container.get_node("VBoxScore")
onready var score_gui: Label = v_box_score.get_node("DiamondGUI/Score")

export(Array, String) var health_texture

func update_gui(value: int, type: String) -> void:
	match type:
		"Damage":
			health_gui.texture = load(health_texture[value])
			
		"Support":
			health_gui.texture = load(health_texture[value])
			
		"Extra":
			score_gui.text = str(value)
