extends Node2D
class_name LevelManager

onready var player: KinematicBody2D = get_node("King")
onready var camera_ref: Camera2D = player.get_node("Camera")
onready var world_tile: TileMap = get_node("World")
onready var interface: CanvasLayer = get_node("HUD")
onready var door_begin: Area2D = get_node("DoorBegin")
onready var door_end: Area2D = get_node("DoorEnd")

func _ready() -> void:
	connect_signals()
	set_camera_limits()
	
	
func connect_signals() -> void:
	var _hud_connect = interface.connect("start_level", door_begin, "door_opening")
	var _change_level_connect = interface.connect("change_level", self, "change_level")
	var _door_begin_connect = door_begin.connect("load_player", player.get_node("Texture"), "door_out_animation")
	var _door_end_connect = door_end.connect("fade_in", interface, "fade_in_animation")
	
	
func change_level() -> void:
	Globals.data_dictionary.health = player.get_node("HitBox").health
	Globals.data_dictionary.money = player.get_node("HitBox").money
	Globals.data_dictionary.level_path = door_end.next_level_path
	Globals.save_data()
	var _change_scene = get_tree().change_scene(door_end.next_level_path)
	
	
func set_camera_limits() -> void:
	var camera_offset: float = camera_ref.offset.y
	var tile_used_rect: Rect2 = world_tile.get_used_rect()
	var cell_size: float = world_tile.cell_size.x
	camera_ref.limit_left = int(tile_used_rect.position.x)
	camera_ref.limit_right = int(tile_used_rect.size.x * cell_size)
	camera_ref.limit_top = int(tile_used_rect.position.y - camera_offset)
