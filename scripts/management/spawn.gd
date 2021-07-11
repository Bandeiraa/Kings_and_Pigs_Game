extends Node2D

const SLICE = preload("res://scenes/management/slice.tscn")

var type: String = "Normal"

export(Array, String) var sliced_box

func _ready() -> void:
	break_crate()
	
	
func break_crate() -> void:
	match type:
		"Support":
			create_slices()
			
		"Normal":
			create_slices()
			
	queue_free()
	
	
func create_slices() -> void:
	randomize()
	sliced_box.shuffle()
	for slice in sliced_box.size():
		var instanced_slice = SLICE.instance()
		instanced_slice.get_node("Texture").texture = load(sliced_box[slice])
		instanced_slice.global_position = global_position
		get_tree().root.call_deferred("add_child", instanced_slice)
