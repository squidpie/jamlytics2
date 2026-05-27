extends Node

signal level_complete
signal level_reset
signal ammo_launched
signal reloaded

@export var level = 0
var passed = false
var HUD
var shard_mask = 0b000000


func _enter_tree() -> void:
	$Launcher/AmmoSelector.shard_mask = shard_mask


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD/Exit.pressed.connect(complete_level)
	$HUD/Reset.pressed.connect(reset_level)
	$Structure/Enemies.get_child(0).enemy_died.connect(_on_level_passed)
	$Launcher.ammo_launched.connect(_on_ammo_launched)
	$Launcher.reloaded.connect(_on_reloaded)
	print("loaded level " + str(level))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func reset_level() -> void:
	print("Resetting Level")
	level_reset.emit()
	queue_free()


func complete_level() -> void:
	if not get_parent():
		return
	get_parent().remove_child(self)
	emit_signal("level_complete", [level, passed, int($HUD/Score.text)])


func _on_level_passed() -> void:
	passed = true
	await get_tree().create_timer(2).timeout
	complete_level()


func _on_label_timer_expire() -> void:
	$Label/AnimationPlayer.play("level_load_text")


func _on_label_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and OS.has_feature("debug"):
		passed = true
		complete_level()


func _on_ammo_launched() -> void:
	ammo_launched.emit()


func _on_reloaded() -> void:
	reloaded.emit()
