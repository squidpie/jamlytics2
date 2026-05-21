extends Control

signal load_level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ConfigMenu.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func update(level: int, passed: bool) -> void:
	if level > 6:
		return
	var slider:VSlider = get_node("ShardSlider" + str(level))
	if passed:
		$CoreIcon.update(level)
		slider.hide()
	else:
		slider.value = slider.max_value


func _on_shard_slider_1_shard_selected() -> void:
	emit_signal("load_level", [1])


func _on_shard_slider_2_shard_selected() -> void:
	emit_signal("load_level", [2])


func _on_shard_slider_3_shard_selected() -> void:
	emit_signal("load_level", [3])


func _on_shard_slider_4_shard_selected() -> void:
	emit_signal("load_level", [4])


func _on_shard_slider_5_shard_selected() -> void:
	emit_signal("load_level", [5])


func _on_shard_slider_6_shard_selected() -> void:
	emit_signal("load_level", [6])


func _on_core_button_press() -> void:
	emit_signal("load_level", [7])


func _on_config_button_pressed() -> void:
	$ConfigMenu.show()
