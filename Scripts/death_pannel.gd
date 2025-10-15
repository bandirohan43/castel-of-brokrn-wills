extends PanelContainer
@onready var button: AudioStreamPlayer2D = $"../../button"

@onready var respawn_button = $VBoxContainer/Respawn
@onready var main_menu_button = $VBoxContainer/Mainmenu

func _ready():
	visible = false

	if respawn_button:
		respawn_button.pressed.connect(_on_respawn_pressed)
	else:
		print("Respawn button not found!")

	if main_menu_button:
		main_menu_button.pressed.connect(_on_main_menu_pressed)
	else:
		print("Main Menu button not found!")

func show_death_screen():
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true

func _on_respawn_pressed():
	button.play()
	visible = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.global_transform.origin = player.respawn_position
		player.can_move = true

func _on_main_menu_pressed():
	button.play()
	visible = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
