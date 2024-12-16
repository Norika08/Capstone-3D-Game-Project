extends CSGBox3D


## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

# Grass に入ったプレイヤーを検出する
#func _ready():
	# シグナルを接続
	#connect("body_entered", self, "_on_body_entered")

# プレイヤーが Grass に入ったときの処理
func _on_body_entered(body: Node):
	# CharacterBody3D がプレイヤーである場合のチェック
	if body is CharacterBody3D:
		print("Player has entered the Grass area!")
		# プレイヤーの動作をトリガー
		body.reset_position()  # プレイヤーにリセット動作をさせる例


func _on_area_3d_body_entered(body: Node3D) -> void:
	pass # Replace with function body.
