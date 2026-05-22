extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func show_scene(scene_name: String) -> void:
	var scene = load("res://cutscenes/" + scene_name + ".tscn")
	var scene_instance = scene.instantiate()
	add_child(scene_instance)
