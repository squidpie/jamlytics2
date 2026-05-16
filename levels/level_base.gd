extends Node

@export var level = 0


func load() -> void:
	print("loaded level " + str(level))


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
