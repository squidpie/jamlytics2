extends Node

var shard_mask = 0b000000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioEngine.start_loop("main_theme")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_main_menu_load_level(args) -> void:
	var level = args[0]
	$AudioEngine.stop_loop()
	$LevelLoader.load_level(level, shard_mask)
	$MainMenu.hide()


func _on_level_load_complete() -> void:
	var level = $LevelLoader.get_child(0)
	level.level_complete.connect(_on_level_complete)
	$AudioEngine.load_layer(str(level.level))
	$AudioEngine.start_layer()


func _on_level_complete(args) -> void:
	var level = args[0]
	var passed = args[1]
	$MainMenu.update(level, passed)
	$MainMenu.show()
	$AudioEngine.stop_layer()
	if not passed:
		$AudioEngine.unload_last_layer()
	$AudioEngine.start_loop("main_theme")
	if passed:
		shard_mask |= 1 << (level - 1)
