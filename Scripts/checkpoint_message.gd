extends Control
@onready var label = $Label

var display_time = 1.5

func show_message():
	
	label.visible = true
	visible = true

	await get_tree().create_timer(display_time).timeout
	label.visible = false
	visible = false
