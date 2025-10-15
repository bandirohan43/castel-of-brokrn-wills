extends Control

@onready var restart_button = $PanelContainer/VBoxContainer/Restart
@onready var main_menu_button = $PanelContainer/VBoxContainer/MainMenu
@onready var quit_button = $PanelContainer/VBoxContainer/Quit

func _ready():
	visible = false
	restart_button.pressed.connect(_on_restart_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

func show_win_screen():
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true

func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_quit_pressed():
	get_tree().quit()
