extends Node3D

func _ready():
	randomize()

	var pairs = [
		["G1", "G10"],
		["G20", "G9"],
		["G19", "G8"],
		["G18", "G7"],
		["G17", "G6"],
		["G16", "G5"],
		["G15", "G4"],
		["G14", "G3"],
		["G13", "G2"],
		["G12", "G21"],
		["G11", "G22"]
	]

	for pair in pairs:
		var glass1 = get_node_or_null(pair[0])
		var glass2 = get_node_or_null(pair[1])

		if not glass1 or not glass2:
			print("❌ Missing one of: ", pair)
			continue

		var solid_first = randf() < 0.5
		_set_glass_state(glass1, solid_first)
		_set_glass_state(glass2, not solid_first)

	print("✅ Random glass setup complete!")


func _set_glass_state(glass: Node3D, solid: bool):
	var static_body = glass.get_node_or_null("StaticBody3D")
	var mesh = glass.get_node_or_null("MeshInstance3D")
	var collider = glass.get_node_or_null("CollisionShape3D")

	if static_body:
		static_body.process_mode = Node.PROCESS_MODE_DISABLED if not solid else Node.PROCESS_MODE_INHERIT

	if collider:
		collider.disabled = not solid

	if mesh:
		mesh.modulate = Color(1, 1, 1, 1.0 if solid else 0.4)
