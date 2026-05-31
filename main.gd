extends Node

var shard_mask = 0b000000
var final_score = ""
var is_tutorial_active = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MainMenu/ConfigMenu/PlayTutorialButton.pressed.connect(_on_play_tutorial_pressed)
	$AudioEngine.start_loop("main_theme")
	$CutsceneLoader.show_scene("intro")
	$CutsceneLoader.show_scene("splash_screen")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_main_menu_load_level(args) -> void:
	var level = args[0]
	$AudioEngine.stop_loop()
	$AudioEngine.play_fx("click")
	await get_tree().create_timer(0.3).timeout
	$LevelLoader.load_level(level, shard_mask)
	$MainMenu.hide()
	if is_tutorial_active:
		$TutorialLoader/MainMenuTutorial.hide()
		$TutorialLoader/LauncherTutorial.show()


func _on_level_load_complete() -> void:
	var level = $LevelLoader.get_child(0)
	connect_level(level)
	if is_tutorial_active:
		level.ammo_launched.connect($TutorialLoader._on_ammo_launched)
		level.reloaded.connect($TutorialLoader._on_reloaded)
	$AudioEngine.load_layer(str(level.level))
	$AudioEngine.start_layer()


func _on_level_complete(args) -> void:
	var level = args[0]
	var passed = args[1]
	var score = args[2]
	$MainMenu.update(level, passed, score)
	$MainMenu.show()
	$AudioEngine.stop_layer()
	$AudioEngine.start_loop("main_theme")
	if is_tutorial_active:
		$TutorialLoader/LauncherTutorial.hide()
		is_tutorial_active = false
	if passed and level < 7:
		shard_mask |= 1 << (level - 1)
		$CutsceneLoader.show_scene("shard_fuse_" + str(level))
	elif passed and level == 7:
		shard_mask = 0
		final_score = $MainMenu/Score.text
		$MainMenu/Score.text = "0"
		$CutsceneLoader.show_scene("intro")
		$CutsceneLoader.show_scene("splash_screen")
		$CutsceneLoader.show_scene("credits")
		$CutsceneLoader.show_scene("victory")
	else:
		$AudioEngine.unload_last_layer()


func _on_level_reset() -> void:
	var level = $LevelLoader.reload_level()
	connect_level(level)


func connect_level(level) -> void:
	level.level_complete.connect(_on_level_complete)
	level.level_reset.connect(_on_level_reset)


func _on_play_tutorial_pressed() -> void:
	is_tutorial_active = true
	$TutorialLoader/MainMenuTutorial.show()
