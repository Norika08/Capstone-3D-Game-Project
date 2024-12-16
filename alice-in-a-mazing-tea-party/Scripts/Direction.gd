extends Node

@export var player_body: CharacterBody3D
@export var camera: Camera3D
@onready var camera_3d = $Neck/Camera3D
@onready var neck = $Neck

const SPEED = 5.0

func _process(delta):
	if not player_body or not camera:
		return
	
	# Get input direction for movement.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	if input_dir != Vector2.ZERO:
		# Use the camera's orientation to calculate movement direction.
		var camera_basis = camera.global_transform.basis
		var move_direction = (camera_basis.x * input_dir.x + camera_basis.z * input_dir.y).normalized()
		
		# Update player_body's velocity.
		var velocity = player_body.velocity
		velocity.x = move_direction.x * SPEED
		velocity.z = move_direction.z * SPEED
		player_body.velocity = velocity
	else:
		# Decelerate when no input.
		var velocity = player_body.velocity
		velocity.x = player_body.move_toward(velocity.x, 0, SPEED)
		velocity.z = player_body.move_toward(velocity.z, 0, SPEED)
		player_body.velocity = velocity

	player_body.move_and_slide()
