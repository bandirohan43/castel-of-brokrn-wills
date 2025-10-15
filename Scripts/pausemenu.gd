extends Control
@onready var button: AudioStreamPlayer2D = $"../button"

@onready var resume_button = $VBoxContainer/Resume
@onready var restart_button = $VBoxContainer/Restart
@onready var main_menu_button = $VBoxContainer/Quit

var pause_toggle = false

func _ready():
	visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	resume_button.pressed.connect(_on_resume_pressed)
	restart_button.pressed.connect(_on_restart_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)

func _input(event):
	if event.is_action_pressed("ESC"):
		var death_ui = get_tree().get_first_node_in_group("death_ui")
		if death_ui == null or not death_ui.visible:
			pause_and_unpause()

func pause_and_unpause():
	pause_toggle = !pause_toggle
	get_tree().paused = pause_toggle
	visible = pause_toggle
	if pause_toggle:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_resume_pressed():
	button.play()
	pause_and_unpause()

func _on_restart_pressed():
	button.play()
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_main_menu_pressed():
	button.play()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
