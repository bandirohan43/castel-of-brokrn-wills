extends Area3D

func _on_body_entered(body):
	if body.is_in_group("player"):
		var win_ui = get_tree().get_first_node_in_group("win_ui")
		if win_ui:
			win_ui.show_win_screen()
