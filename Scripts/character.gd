extends CharacterBody3D

const SPEED = 10.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.003

@onready var camera_3D = $Camera3D

var rotation_x = 0.0
var can_move = true
var respawn_position: Vector3

var bob_timer = 0.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	respawn_position = global_transform.origin  

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ESC"):
		var pause_ui = get_tree().get_first_node_in_group("pause_ui")
		var death_ui = get_tree().get_first_node_in_group("death_ui")

		if pause_ui and (death_ui == null or not death_ui.visible):
			if pause_ui.visible:
				pause_ui.hide_pause_menu()
			else:
				pause_ui.show_pause_menu()

	if not can_move:
		return 

	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		rotation_x -= event.relative.y * MOUSE_SENSITIVITY
		rotation_x = clamp(rotation_x, deg_to_rad(-80), deg_to_rad(80))
		camera_3D.rotation.x = lerp_angle(camera_3D.rotation.x, rotation_x, 0.2)

func _physics_process(delta: float) -> void:
	if not can_move:
		return  

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("JUMP") and is_on_floor():
		velocity.y = JUMP_VELOCITY * 1.0

	var input_dir := Input.get_vector("A", "D", "W", "S")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction != Vector3.ZERO:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED

		bob_timer += delta * 10.0
		camera_3D.position.y = sin(bob_timer) * 0.0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		camera_3D.position.y = 0

	move_and_slide()
	

func die():
	can_move = false
	velocity = Vector3.ZERO
	print(" Player died...")

	var death_ui = get_tree().get_first_node_in_group("death_ui")
	if death_ui:
		death_ui.show_death_screen()
	else:
		await get_tree().create_timer(0.5).timeout
		global_transform.origin = respawn_position
		can_move = true
		print("Player respawned at:", respawn_position)


func set_checkpoint(pos: Vector3):
	respawn_position = pos
	print("New checkpoint set:", pos)

	var msg_ui = get_tree().get_first_node_in_group("checkpoint_ui")
	if msg_ui:
		msg_ui.show_message()
