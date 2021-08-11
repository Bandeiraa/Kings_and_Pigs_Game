extends TextureRect
class_name SaveManager

signal warning_popup
signal new_game
signal continue_game

var save_path: String

onready var label: Label = get_node("Label")
onready var hbox: HBoxContainer = get_node("HBox")
onready var slot_name: Label = hbox.get_node("VBox/Name")
onready var slot_level: Label = hbox.get_node("VBox/Level")

func _ready() -> void:
	verify_saved_data()
	
	
func verify_saved_data() -> void:
	Globals.save_path = Globals.SAVE_DIR + name.to_lower() + "save.dat"
	save_path = Globals.save_path
	var file: File = File.new()
	if file.file_exists(save_path):
		Globals.load_data()
		if Globals.data_dictionary.current_slot == name:
			label.hide()
			hbox.show()
			slot_name.text = Globals.data_dictionary.name
			slot_level.text = "Level: " + str(Globals.data_dictionary.level)
	else:
		hbox.hide()
		label.show()
		
		
func verify_slot(type: String) -> void:
	var file: File = File.new()
	Globals.data_dictionary.current_slot = name
	Globals.save_path = Globals.SAVE_DIR + name.to_lower() + "save.dat"
	match type:
		"New Game":
			if file.file_exists(save_path):
				emit_signal("warning_popup")
			else:
				emit_signal("new_game")
				
		"Continue":
			if file.file_exists(save_path):
				#Persist Data and load game
				emit_signal("continue_game")
			else:
				#Can be a Label showing this message
				#"Go to New Game tab if you want to create a new save file"
				pass
