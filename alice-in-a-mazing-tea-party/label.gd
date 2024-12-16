#extends Label
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
extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#text = "Game Clear!!"  # ラベルにテキストを設定
	visible = true  # ラベルを表示

	# フォントのサイズと色を変更
	#self.add_color_override("font_color", Color(1, 0, 0))  # 赤色
	#self.add_font_override("font", load("res://path_to_font.tres"))  # フォントを変更

	# 3秒後にラベルを非表示にする
	#await get_tree().create_timer(3.0).timeout
	#visible = false  # ラベルを非表示にする
