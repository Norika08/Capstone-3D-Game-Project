#extends CharacterBody3D
#
#@onready var camera_3d = $Neck/Camera3D
#@onready var neck = $Neck
#
#@export var movement_sens = 0.05
#
#const SPEED = 1.0
#const JUMP_VELOCITY = 2.5
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
#
#func _physics_process(delta):
	## Add gravity
	#if not is_on_floor():
		#velocity.y -= gravity * delta
#
	## Handle jump
	#if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("jump")) and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get input direction for character movement
	#var move_input = Input.get_vector("go_left", "go_right", "go_foward", "go_back")
#
	#if move_input != Vector2.ZERO:
		## Get camera's forward (-z) and right (+x) vectors
		#var camera_basis = camera_3d.transform.basis
		#var forward = -camera_basis.z.normalized()  # Forward direction is -Z
		#var right = camera_basis.x.normalized()     # Right direction is +X
#
		## Calculate movement direction based on camera orientation
		#var move_direction = (right * move_input.x + forward * move_input.y).normalized()
#
		## Apply movement direction to velocity
		#velocity.x = move_direction.x * SPEED
		#velocity.z = move_direction.z * SPEED
	#else:
		## Decelerate smoothly when there's no input
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
#
	## Apply movement
	#move_and_slide()
#
	## Camera control
	#if Input.is_action_pressed("camera_up"):
		#camera_3d.rotate_x(movement_sens)
	#if Input.is_action_pressed("camera_down"):
		#camera_3d.rotate_x(-movement_sens)
	#if Input.is_action_pressed("camera_left"):
		#neck.rotate_y(movement_sens)
	#if Input.is_action_pressed("camera_right"):
		#neck.rotate_y(-movement_sens)
#
	## Clamp the camera's vertical rotation
	#camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-30), deg_to_rad(60))

#extends CharacterBody3D
#
#@onready var camera_3d = $Neck/Camera3D
#@onready var neck = $Neck
#
#@export var movement_sens = 0.05
#
#const SPEED = 1.0
#const JUMP_VELOCITY = 2.5
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
#
#func _physics_process(delta):
	## Add gravity
	#if not is_on_floor():
		#velocity.y -= gravity * delta
#
	## Handle jump
	#if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("jump")) and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get input direction for character movement
	#var move_input = Input.get_vector("go_left", "go_right", "go_forward", "go_back")
#
	#if move_input != Vector2.ZERO:
		## Get camera's basis to calculate the movement direction
		#var camera_basis = camera_3d.global_transform.basis
		#var forward = -camera_basis.z.normalized()  # Forward direction is -Z
		#var right = camera_basis.x.normalized()     # Right direction is +X
#
		## Calculate movement direction based on input and camera orientation
		#var move_direction = (right * move_input.x + forward * move_input.y).normalized()
#
		## Apply movement direction to velocity
		#velocity.x = move_direction.x * SPEED
		#velocity.z = move_direction.z * SPEED
	#else:
		## Decelerate smoothly when there's no input
		#velocity.x = move_toward(velocity.x, 0, SPEED * delta)
		#velocity.z = move_toward(velocity.z, 0, SPEED * delta)
#
	## Apply movement
	#move_and_slide()
#
	## Camera control
	#if Input.is_action_pressed("camera_up"):
		#camera_3d.rotate_x(movement_sens)
	#if Input.is_action_pressed("camera_down"):
		#camera_3d.rotate_x(-movement_sens)
	#if Input.is_action_pressed("camera_left"):
		#neck.rotate_y(movement_sens)
	#if Input.is_action_pressed("camera_right"):
		#neck.rotate_y(-movement_sens)
#
	## Clamp the camera's vertical rotation
	#camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-30), deg_to_rad(60))

extends CharacterBody3D

@onready var camera_3d = $Neck/Camera3D
@onready var neck = $Neck

@onready var game_clear_view = $GameClearView  # Game Clear View ノードへの参照

@export var movement_sens = 0.05
var Potion = 0

const SPEED = 0.5
const JUMP_VELOCITY = 2.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Add gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump
	if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("jump")) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get input direction for character movement
	var move_input = Input.get_vector("go_left", "go_right", "go_forward", "go_back")

	if move_input != Vector2.ZERO:
		# Get camera's basis to calculate the movement direction
		var camera_basis = camera_3d.global_transform.basis
		var forward = camera_basis.z.normalized()  # Forward direction is -Z
		var right = camera_basis.x.normalized()     # Right direction is +X

		# Calculate movement direction based on input and camera orientation
		var move_direction = (right * move_input.x + forward * move_input.y).normalized()

		# Apply movement direction to velocity
		velocity.x = move_direction.x * SPEED
		velocity.z = move_direction.z * SPEED
	
	else:
		# Stop movement immediately when there's no input
		velocity.x = 0
		velocity.z = 0

	#else:
		## Decelerate smoothly when there's no input
		#velocity.x = move_toward(velocity.x, 0, SPEED * delta)
		#velocity.z = move_toward(velocity.z, 0, SPEED * delta)

	# Apply movement
	move_and_slide()

	# Camera control
	if Input.is_action_pressed("camera_up"):
		camera_3d.rotate_x(movement_sens)
	if Input.is_action_pressed("camera_down"):
		camera_3d.rotate_x(-movement_sens)
	if Input.is_action_pressed("camera_left"):
		neck.rotate_y(movement_sens)
	if Input.is_action_pressed("camera_right"):
		neck.rotate_y(-movement_sens)

	# Clamp the camera's vertical rotation
	camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-30), deg_to_rad(60))

	# Check for game clear condition
	check_game_clear()
	
func pick():
	Potion += 1
	print (Potion)

func check_game_clear():
	if Potion >= 7:
		print("Game Clear!")
		# Switch to the Game Clear View
		switch_to_game_clear_view()
func switch_to_game_clear_view():
	# Deactivate current player character
	self.visible = false
	self.set_physics_process(false)
	
	# Activate Game Clear View
	game_clear_view.visible = true
	game_clear_view.set_physics_process(true)
	
	# Optionally, position the Game Clear View
	game_clear_view.global_transform = self.global_transform
