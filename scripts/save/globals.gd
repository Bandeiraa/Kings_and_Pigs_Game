extends Node

const SAVE_DIR: String = "user://saves/"

var save_path: String
var data_dictionary: Dictionary = {
	"current_slot": "",
	"name": "",
	"level": 1,
	"level_path": "",
	"health": 6,
	"attack": 1,
	"money": 0
}

func save_data() -> void:
	var dir: Directory = Directory.new()
	if not dir.dir_exists(SAVE_DIR):
		var _make_directory = dir.make_dir_recursive(SAVE_DIR)
		
	var file: File = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(data_dictionary)
		file.close()
		
		
func load_data() -> void:
	var file: File = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			data_dictionary = file.get_var()
			file.close()
