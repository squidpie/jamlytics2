extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_main_menu_load_level(_args) -> void:
	$MainMenu.hide()
	$HUD.show()


func _on_level_load_complete() -> void:
	var level = $LevelLoader.get_child(0)
	level.level_complete.connect(_on_level_complete)


func _on_level_complete(args) -> void:
	var level = args[0]
	var passed = args[1]
	$MainMenu.update(level, passed)
	$HUD.hide()
	$MainMenu.show()
