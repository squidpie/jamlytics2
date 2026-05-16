extends Control

signal load_level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_fragment_slider_1_fragment_selected() -> void:
	emit_signal("load_level", [1])
	hide()

func _on_fragment_slider_2_fragment_selected() -> void:
	emit_signal("load_level", [2])
	hide()

func _on_fragment_slider_3_fragment_selected() -> void:
	emit_signal("load_level", [3])
	hide()

func _on_fragment_slider_4_fragment_selected() -> void:
	emit_signal("load_level", [4])
	hide()

func _on_fragment_slider_5_fragment_selected() -> void:
	emit_signal("load_level", [5])
	hide()

func _on_fragment_slider_6_fragment_selected() -> void:
	emit_signal("load_level", [6])
	hide()
