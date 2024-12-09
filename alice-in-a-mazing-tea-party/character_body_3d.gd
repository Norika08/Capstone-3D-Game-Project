extends CharacterBody3D

@onready var camera_3d = $Neck/Camera3D
@onready var neck = $Neck


@export var movement_sens = 0.05


const SPEED = 8.0
const JUMP_VELOCITY = 2.5



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")



func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")

	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	if Input.is_action_pressed("camera_up"):
		camera_3d.rotate_x(movement_sens)
	if Input.is_action_pressed("camera_down"):
		camera_3d.rotate_x(-movement_sens)
	if Input.is_action_pressed("camera_left"):
		neck.rotate_y(movement_sens)
	if Input.is_action_pressed("camera_right"):
		neck.rotate_y(-movement_sens)
	
	camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-30), deg_to_rad(60))



	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
		# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get input direction for character movement.
	var move_input = Input.get_vector("go_left", "go_right", "go_foward", "go_back")

	# Move the character based on input.
	if move_input != Vector2.ZERO:
		var move_direction = transform.basis * Vector3(move_input.x, 0, move_input.y)
		velocity.x = move_direction.x * SPEED
		velocity.z = move_direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# Apply movement.
	move_and_slide()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
#
	#move_and_slide()
