extends Node3D

@onready var doors = [$"D1", $"D2", $"D3", $"D4", $"D5"]

func _ready():
	randomize()
	print("Doors array:", doors)
	
	var correct_index = randi() % doors.size()
	var correct_door = doors[correct_index]
	
	var collider = get_collider_recursive(correct_door)
	if collider:
		collider.queue_free()
		print("Door ", correct_index + 1, " collider removed!")
	else:
		print("Collider not found for door ", correct_index + 1)

func get_collider_recursive(node):
	for child in node.get_children():
		if child is CollisionShape3D:
			return child
		else:
			var found = get_collider_recursive(child)
			if found:
				return found
	return null
