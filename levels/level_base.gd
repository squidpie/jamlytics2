extends Node

signal level_complete

@export var level = 0
var passed = false
var HUD

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HUD = get_node("/root/Main/HUD")
	HUD.get_child(1).pressed.connect(complete_level)
	HUD.get_child(0).pressed.connect(reset_level)
	print("loaded level " + str(level))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func reset_level() -> void:
	print("Resetting Level")


func complete_level() -> void:
	HUD.get_child(1).pressed.disconnect(complete_level)
	HUD.get_child(0).pressed.disconnect(reset_level)
	var parent = find_parent("LevelLoader")
	parent.remove_child(self)
	emit_signal("level_complete", [level, passed])


func _on_label_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		passed = true
		complete_level()
