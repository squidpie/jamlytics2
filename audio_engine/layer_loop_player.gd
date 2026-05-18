extends Node

signal finished

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func connect_child(node: AudioStreamPlayer) -> void:
	node.finished.connect(_on_child_finished)

func disconnect_child(node: AudioStreamPlayer) -> void:
	node.finished.disconnect(_on_child_finished)

func _on_child_finished() -> void:
	var all_done = false
	for player: AudioStreamPlayer in get_children():
		if player.completed:
			all_done = true
		else:
			all_done = false
			break
	if all_done:
		finished.emit()
