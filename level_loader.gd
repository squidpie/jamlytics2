extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func load_level(level: int) -> void:
	print("Loading Level " + str(level))
	var main = get_node("/root/Main")
	var selected_level = load("res://levels/level_" + str(level) + ".tscn")
	var level_instance = selected_level.instantiate()
	level_instance.level = level	
	main.add_child(level_instance)
	level_instance.load()


func _on_main_menu_load_level(args) -> void:
	var level = args[0]
	load_level(level)
