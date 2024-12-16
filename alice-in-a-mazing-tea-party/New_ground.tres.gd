extends Node3D


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

#@export var player_start_position: Vector3  # プレイヤーの初期位置を設定
#@onready var player = $"/root/CharacterBody3D"  # プレイヤーのノードパスを指定
#
#func _ready() -> void:
	## プレイヤーの初期位置を現在の位置に設定（デフォルト）
	#if player_start_position == Vector3.ZERO and player:
		#player_start_position = player.global_transform.origin
#
## プレイヤーがエリアに入った場合の処理
#func _on_area_3d_body_entered(body: Node3D) -> void:
	#if body == player:
		#print("Player entered the Ground area. Restarting position...")
		#reset_player_position()
#
#func reset_player_position() -> void:
	#if player:
		## プレイヤーを初期位置に戻す
		#var reset_transform = player.global_transform
		#reset_transform.origin = player_start_position
		#player.global_transform = reset_transform
#
		## プレイヤーの速度をリセット
		#player.velocity = Vector3.ZERO
	#else:
		#print("Error: Player node not found.")


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		body.call("reset_position")  # プレイヤーに「位置をリセット」する関数を呼び出す
