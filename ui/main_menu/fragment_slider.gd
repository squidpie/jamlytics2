extends VSlider

signal fragment_selected

var reset_slider = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if value >= max_value:
		reset_slider = false
	if reset_slider:
		value += max_value * delta
	

func _on_drag_ended(is_value_changed):
	if is_value_changed and value == min_value:
		emit_signal("fragment_selected")
	else:
		reset_slider = true
