extends Node

var last_layer = null
var muted = false
var current_volume = 0
var current_fx_volume = 0
var fx_muted = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MainLoopPlayer.finished.connect(_on_loop_finished)
	$LayerLoopPlayer.finished.connect(_on_layer_finished)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func start_loop(id: String) -> void:
	$MainLoopPlayer.stream = load("res://assets/audio/" + id + ".ogg")
	if not muted:
		$MainLoopPlayer.play()


func stop_loop() -> void:
	$MainLoopPlayer.stop()


func _on_loop_finished() -> void:
	$MainLoopPlayer.play()


func load_layer(id: String) -> void:
	var layer = load("res://audio_engine/audio_layer.tscn")
	var layer_instance = layer.instantiate()
	layer_instance.stream = load("res://assets/audio/layer_" + id + ".ogg")
	layer_instance.volume_db = current_volume
	$LayerLoopPlayer.add_child(layer_instance)
	$LayerLoopPlayer.connect_child(layer_instance)
	last_layer = layer_instance


func unload_last_layer() -> void:
	if not last_layer:
		return
	$LayerLoopPlayer.disconnect_child(last_layer)
	$LayerLoopPlayer.remove_child(last_layer)


func start_layer() -> void:
	if muted:
		return
	$LevelLoopPlayer.play()


func stop_layer() -> void:
	$LevelLoopPlayer.stop()


func set_volume(value: float) -> void:
	current_volume = value
	$MainLoopPlayer.volume_db = value
	$LevelLoopPlayer.volume_db = value
	$LayerLoopPlayer.set_volume(value)


func set_mute(mute: bool) -> void:
	muted = mute
	$MainLoopPlayer.stream_paused = mute
	if not muted:
		$MainLoopPlayer.play()

func set_fx_volume(value: float) -> void:
	current_fx_volume = value
	$FXPlayer.volume_db = value


func set_fx_mute(mute: bool) -> void:
	fx_muted = mute
	$FXPlayer.stream_paused = mute


func _on_layer_finished() -> void:
	start_layer()


func play_fx(id: String) -> void:
	if fx_muted:
		return
	$FXPlayer.stream = load("res://assets/audio/fx/" + id + ".wav")
	$FXPlayer.volume_db = current_fx_volume
	$FXPlayer.play()


func play_clip(index: int) -> void:
	$LevelLoopPlayer.get_stream_playback().switch_to_clip(index)
