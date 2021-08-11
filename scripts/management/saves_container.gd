extends VBoxContainer

signal button_pressed
signal show_popup

var current_slot: TextureRect = null
var type: String

onready var slots_container: GridContainer = get_node("GContainer")

export(bool) var can_interact = true

func _ready() -> void:
	for slot in slots_container.get_children():
		slot.connect("mouse_entered", self, "mouse_entered", [slot.name])
		slot.connect("mouse_exited", self, "mouse_exited", [slot.name])
		slot.connect("warning_popup", self, "popup")
		slot.connect("new_game", self, "new_game")
		slot.connect("continue_game", self, "continue_game")
		
		
func set_type(new_type: String) -> void:
	type = new_type
	
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Left_Click") and current_slot != null and can_interact:
		current_slot.verify_slot(type)
		
		
func popup() -> void:
	emit_signal("show_popup")
	
	
func new_game() -> void:
	emit_signal("button_pressed", "YesButton")
	
	
func continue_game() -> void:
	emit_signal("button_pressed", "ContinueGame")
	
	
func mouse_entered(slot: String) -> void:
	current_slot = slots_container.get_node(slot)
	current_slot.modulate = Color("6effffff")
	
	
func mouse_exited(slot: String) -> void:
	current_slot = null
	slots_container.get_node(slot).modulate = Color("ffffff")
