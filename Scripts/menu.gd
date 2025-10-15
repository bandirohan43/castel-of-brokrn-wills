extends Control
@onready var button: AudioStreamPlayer2D = $"../button"

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = false

func _on_start_game_pressed() -> void:
	button.play()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_quit_pressed() -> void:
	button.play()
	get_tree().quit()
