
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

#@onready var game_clear_label = $"../GameClearScreen/CanvasLayer/Label"  # Labelノードを参照
@onready var game_clear_label = $"../GameClearScreen/CanvasLayer/Label"

@onready var game_clear_camera = $"/root/Node3D/Game_Clear_Camera"  # Game_Clear_Camera ノードを参照

@export var movement_sens = 0.05
# プレイヤーの初期位置を記録
var start_position: Vector3 = Vector3(-4.095, 5.407, 0)
var Potion = 0


const SPEED = 0.5
const JUMP_VELOCITY = 2.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


#func _ready():
	#if game_clear_label:
		#game_clear_label.visible = false
	#else:
		#print("Error: Game Clear Label not found")
#func _ready():
	#if game_clear_label:
		#game_clear_label.visible = false
		#print("Game Clear label initialized.")
	#else:
		#print("Error: Game Clear Label not found")
#func _ready():
	#if game_clear_label:
		#game_clear_label.visible = false  # ゲーム開始時は非表示
# ゲーム開始時にラベルを非表示にする
func _ready():
	# ラベルの参照が正しいかを確認する
	if game_clear_label:
		game_clear_label.visible = false  # ゲーム開始時は非表示にする
		print("Game Clear label initialized and set to invisible.")
	else:
		print("Error: Game Clear Label not found")

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



	check_game_clear()
	
func check_game_clear():
	if Potion >= 7:
		print("Game Clear!")
		show_game_clear_label()  # ゲームクリア時にラベル表示を呼び出す
		# Switch to the Game Clear View
		#switch_to_game_clear_view()
		switch_to_game_clear_camera()

	#visible = false
	#set_physics_process(false)
#
	#if game_clear_view:
		#game_clear_view.visible = true
		#game_clear_view.set_physics_process(true)
		#game_clear_view.global_transform = self.global_transform
		#print("Switched to Game_Clear_View")
	#else:
		#print("Error: Game_Clear_View node not found")

func switch_to_game_clear_camera():
	# プレイヤーのカメラを無効化
	camera_3d.current = false

	# Game_Clear_Camera を有効化
	if game_clear_camera:
		game_clear_camera.current = true
		print("Switched to Game_Clear_Camera")
	else:
		print("Error: Game_Clear_Camera node not found")


func _on_area_3d_body_entered(body: Node3D) -> void:
	pass # Replace with function body.

#func reset_position() -> void:
	#print("Resetting position to start!")
	#global_transform.origin = start_position  # 初期位置に戻す
	##velocity = Vector3.ZERO  # 動きをリセット
func reset_position() -> void:
	print("Resetting position to start!")
	global_transform.origin = start_position  # 初期位置に戻す
	velocity = Vector3.ZERO  # 動きをリセット


#func show_game_clear_text():
	## "Game Clear!!" を表示
	#if game_clear_label:
		##game_clear_label.text = "Game Clear!!"
		#game_clear_label.visible = true
#
		 ##3秒後にテキストを非表示にする
		##await get_tree().create_timer(3.0).timeout
		##game_clear_label.visible = false
#func show_game_clear_label():
	#if game_clear_label:
		#game_clear_label.text = "How wonderful it is to be whole again! 
#Now, let us begin our curious tea party!"
		#game_clear_label.visible = true
		#await get_tree().create_timer(3.0).timeout
		#game_clear_label.visible = false
	#else:
		#print("Error: Game Clear Label not found")
#func show_game_clear_label():
	#if game_clear_label:
		#game_clear_label.text = "Game Clear!!"
		#game_clear_label.visible = true
		#print("Game Clear label is now visible!")
		#await get_tree().create_timer(3.0).timeout
		#game_clear_label.visible = false
	#else:
		#print("Error: Game Clear Label not found")
#func show_game_clear_label():
	#if game_clear_label:
		#game_clear_label.visible = true  # ラベルを表示
		#print("Game Clear label is now visible!")
	#else:
		#print("Error: Game Clear Label not found")
# ゲームクリアラベル表示
func show_game_clear_label():
	if game_clear_label:
		game_clear_label.visible = true  # ラベルを表示
		print("Game Clear label is now visible!")
	else:
		print("Error: Game Clear Label not found")
