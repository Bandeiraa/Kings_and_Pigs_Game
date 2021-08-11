extends Control

onready var interface_animation: AnimationPlayer = get_node("AnimationPlayer")
onready var interface: Control = get_node("Canvas/Interface")
onready var saves_container: Control = interface.get_node("SavesContainer/HBox")
onready var label_text: LineEdit = interface.get_node("NewGameContainer/TextEdit") 

func _ready() -> void:
	connect_signals()
	
	
func connect_signals() -> void:
	for button in get_tree().get_nodes_in_group("Button"):
		button.connect("pressed", self, "button_pressed", [button.name])
		
		
func button_pressed(button_type) -> void:
	match button_type:
		"NewGame":
			interface_animation.play("saves_from_ng_btn")
			
		"Continue":
			interface_animation.play("saves_from_continue")
			
		"Quit":
			get_tree().quit()
			
		"UdemyButton":
			var _udemy = OS.shell_open("https://www.udemy.com/user/davi-bandeira-2/")
			
		"YesButton":
			interface_animation.play("ng_from_saves")
			
		"YesPopupButton":
			interface_animation.play("ng_from_popup")
			
		"NoPopupButton":
			interface_animation.play("saves_from_popup")
			
		"BackButton":
			if saves_container.can_interact:
				interface_animation.play("popup_from_ng")
			else:
				interface_animation.play("saves_from_ng")
				
		"MenuButton":
			interface_animation.play("saves_from_menu")
			
		"ConfirmButton":
			interface_animation.play("fade_in")
			
		"ContinueGame":
			interface_animation.play("fade_in_continue")
			
			
func show_saves_container(type: String) -> void:
	interface_animation.play("show_saves_container")
	saves_container.set_type(type)
	
	
func back_to_menu() -> void:
	interface_animation.play("show_menu_container")
	
	
func show_popup() -> void:
	interface_animation.play("popup_from_saves")


func on_text_entered(new_text: String) -> void:
	Globals.data_dictionary.name = new_text
	Globals.save_data()
	var _change_scene = get_tree().change_scene("res://scenes/management/world_manager.tscn")
	
	
func new_game() -> void:
	var nickname: String = label_text.text
	Globals.data_dictionary.money = 0
	Globals.data_dictionary.health = 6
	Globals.data_dictionary.name = nickname
	Globals.data_dictionary.level_path = "res://scenes/management/tutorial_level.tscn"
	Globals.save_data()
	var _change_scene = get_tree().change_scene(Globals.data_dictionary.level_path)


func continue_game():
	Globals.load_data()
	var _change_scene = get_tree().change_scene(Globals.data_dictionary.level_path)
