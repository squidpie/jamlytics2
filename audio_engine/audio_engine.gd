extends Node

var last_layer = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MainLoopPlayer.finished.connect(_on_loop_finished)
	$LayerLoopPlayer.finished.connect(_on_layer_finished)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func start_loop(id: String) -> void:
	$MainLoopPlayer.stream = load("res://assets/audio/" + id + ".ogg")
	$MainLoopPlayer.play()

func stop_loop() -> void:
	$MainLoopPlayer.stop()

func _on_loop_finished() -> void:
	$MainLoopPlayer.play()

func load_layer(id: String) -> void:
	var layer = load("res://audio_engine/audio_layer.tscn")
	var layer_instance = layer.instantiate()
	layer_instance.stream = load("res://assets/audio/layer_" + id + ".ogg")
	$LayerLoopPlayer.add_child(layer_instance)
	$LayerLoopPlayer.connect_child(layer_instance)
	last_layer = layer_instance

func unload_last_layer() -> void:
	if not last_layer:
		return
	$LayerLoopPlayer.disconnect_child(last_layer)
	$LayerLoopPlayer.remove_child(last_layer)

func start_layer() -> void:
	for player in $LayerLoopPlayer.get_children():
		player.play()

func stop_layer() -> void:
	for player in $LayerLoopPlayer.get_children():
		player.stop()

func _on_layer_finished() -> void:
	start_layer()
