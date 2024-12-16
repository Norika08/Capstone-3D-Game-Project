#extends CharacterBody3D
#
#@onready var camera_3d = $Neck2/Camera3D
#@onready var neck = $Neck2
#@onready var game_clear_view = $GameClearView  # GameClearViewノードを参照
#
#
#@export var movement_sens = 0.05
#
#const SPEED = 5.0
#const JUMP_VELOCITY = 4.5
#
#
##func _physics_process(delta: float) -> void:
	### Add the gravity.
	##if not is_on_floor():
		##velocity += get_gravity() * delta
##
	### Handle jump.
	##if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		##velocity.y = JUMP_VELOCITY
##
	### Get the input direction and handle the movement/deceleration.
	### As good practice, you should replace UI actions with custom gameplay actions.
	##var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	##var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	##if direction:
		##velocity.x = direction.x * SPEED
		##velocity.z = direction.z * SPEED
	##else:
		##velocity.x = move_toward(velocity.x, 0, SPEED)
		##velocity.z = move_toward(velocity.z, 0, SPEED)
##
	##move_and_slide()
#func _physics_process(delta):
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
#@onready var camera_3d = $Neck2/Camera3D
#@onready var neck = $Neck2
#@onready var game_clear_view = $"../Game_Clear_View"  # Game_Clear_Viewを親ノードから取得
#
#@export var movement_sens = 0.05
#
#var potion_count = 0  # ポーションの数を記録
#const REQUIRED_POTIONS = 7  # ゲームクリアに必要なポーションの数
#
#const SPEED = 5.0
#const JUMP_VELOCITY = 4.5
#
#
#
#func add_potion():
	#potion_count += 1
	#print("Potion count: ", potion_count)
	#if potion_count >= REQUIRED_POTIONS:
		#switch_to_game_clear_view()
#
#func switch_to_game_clear_view():
	#print("Game clear condition met!")
	## 現在のキャラクターを非表示にして無効化
	#visible = false
	#set_physics_process(false)
#
	## Game_Clear_View を有効化
	#if game_clear_view:
		#game_clear_view.visible = true
		#game_clear_view.set_physics_process(true)
		#print("Switched to Game_Clear_View")
#
#func _physics_process(delta):
	## カメラ制御
	#if Input.is_action_pressed("camera_up"):
		#camera_3d.rotate_x(movement_sens)
	#if Input.is_action_pressed("camera_down"):
		#camera_3d.rotate_x(-movement_sens)
	#if Input.is_action_pressed("camera_left"):
		#neck.rotate_y(movement_sens)
	#if Input.is_action_pressed("camera_right"):
		#neck.rotate_y(-movement_sens)
#
	## カメラの垂直回転をクランプ
	#camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-30), deg_to_rad(60))

#extends CharacterBody3D
#
#@onready var camera_3d = $Neck2/Camera3D
#@onready var neck = $Neck2
#
#@export var movement_sens = 0.05
#
#func _ready():
	## 初期状態で無効化
	#visible = false
	#set_physics_process(false)
#
#func _physics_process(delta):
	## カメラ制御
	#if Input.is_action_pressed("camera_up"):
		#camera_3d.rotate_x(movement_sens)
	#if Input.is_action_pressed("camera_down"):
		#camera_3d.rotate_x(-movement_sens)
	#if Input.is_action_pressed("camera_left"):
		#neck.rotate_y(movement_sens)
	#if Input.is_action_pressed("camera_right"):
		#neck.rotate_y(-movement_sens)
#
	#camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-30), deg_to_rad(60))

extends CharacterBody3D

@onready var camera_3d = $Neck2/Camera3D
@onready var neck = $Neck2

@export var movement_sens = 0.05

func _ready():
	# 初期状態で無効化
	visible = false
	set_physics_process(false)

	# デバッグ
	print("Camera3D Node: ", camera_3d)
	if camera_3d == null:
		print("Error: Camera3D is null. Check the node path.")

	# カメラの初期状態を無効化
	camera_3d.current = false

func _physics_process(delta):
	# カメラ制御
	if Input.is_action_pressed("camera_up"):
		camera_3d.rotate_x(movement_sens)
	if Input.is_action_pressed("camera_down"):
		camera_3d.rotate_x(-movement_sens)
	if Input.is_action_pressed("camera_left"):
		neck.rotate_y(movement_sens)
	if Input.is_action_pressed("camera_right"):
		neck.rotate_y(-movement_sens)

	# カメラの縦回転を制限
	camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-30), deg_to_rad(60))
