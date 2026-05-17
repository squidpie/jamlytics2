extends AudioStreamPlayer

@export var completed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	finished.connect(_on_finish)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if completed and get_playback_position() != 0:
		completed = false


func _on_finish() -> void:
	completed = true
