extends Panel
@onready var button: AudioStreamPlayer2D = $button

@onready var respawn_button = $DeathPannel/VBoxContainer/Respawn
@onready var main_menu_button = $DeathPannel/VBoxContainer/Mainmenu
@onready var label = $DeathPannel/VBoxContainer/Label

func _ready():
	visible = false
	respawn_button.pressed.connect(_on_respawn_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)

func show_death_screen():
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true

func _on_respawn_pressed():
	button.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().paused = false
	visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.die()

func _on_main_menu_pressed():
	button.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
