#extends CSGBox3D
#
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

#extends CSGBox3D
#
## プレイヤーノードへのパス
#@export var player_path: NodePath
#
#func _ready():
	## コリジョンを自動で有効にする
	#$CollisionShape3D.monitoring = true
	#$CollisionShape3D.connect("body_entered", self, "_on_body_entered")
#
#func _on_body_entered(body):
	#if body == get_node(player_path):  # プレイヤーと比較
		#body.restart()  # プレイヤーのリスタート関数を呼び出す
		#print("Restart triggered!")

extends CSGBox3D

# プレイヤーノードへのパス
@export var player_path: NodePath

func _ready():
	# コリジョンの監視を有効にする
	var collision_shape = $CollisionShape3D
	collision_shape.monitoring = true

	# 接触イベントを監視
	collision_shape.connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body == get_node(player_path):  # プレイヤーと比較
		body.restart()  # プレイヤーのリスタート関数を呼び出す
		print("Restart triggered!")
