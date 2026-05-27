extends Node2D


var is_tutorial_complete = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MainMenuTutorial/ExitButton.pressed.connect(_on_exit_pressed)
	$LauncherTutorial/ExitButton.pressed.connect(_on_exit_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_exit_pressed() -> void:
	hide()


func _on_ammo_launched() -> void:
	if is_tutorial_complete:
		return
	$LauncherTutorial/LauncherTexture.hide()
	$LauncherTutorial/ReloadTexture.show()


func _on_reloaded() -> void:
	$LauncherTutorial.hide()
	is_tutorial_complete = true
