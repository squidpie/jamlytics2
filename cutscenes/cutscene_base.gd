extends Control

var progress = false
var scene_count = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scene_count = get_child_count()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if progress and scene_count:
		remove_child(get_child(-1))
		scene_count -= 1
		progress = false
	if not scene_count:
		get_parent().remove_child(self)


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_released():
			progress = true
