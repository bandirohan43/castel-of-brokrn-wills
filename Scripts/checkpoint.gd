extends Area3D

func _ready():
	monitoring = true
	monitorable = true

	var conn = Callable(self, "_on_body_entered")
	if not is_connected("body_entered", conn):
		connect("body_entered", conn)

func _on_body_entered(body: Node3D) -> void:
	if body.has_method("set_checkpoint"):
		body.set_checkpoint(global_transform.origin)
