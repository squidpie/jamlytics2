extends Node

signal level_load_complete


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func load_level(level: int, shard_mask: int) -> void:
	print("Loading Level " + str(level))
	var selected_level = load("res://levels/level_" + str(level) + ".tscn")
	var level_instance = selected_level.instantiate()
	level_instance.shard_mask = shard_mask
	level_instance.level = level	
	add_child(level_instance)
	emit_signal("level_load_complete")


func reload_level() -> Node:
	var current_level = get_child(0)
	var reloaded_level = load("res://levels/level_" + str(current_level.level) + ".tscn")
	var reloaded_instance = reloaded_level.instantiate()
	reloaded_instance.shard_mask = current_level.shard_mask
	reloaded_instance.level = current_level.level
	remove_child(current_level)
	add_child(reloaded_instance)
	return reloaded_instance
