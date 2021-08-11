extends CanvasModulate

export(Color) var modulate_color

func _ready() -> void:
	color = modulate_color
