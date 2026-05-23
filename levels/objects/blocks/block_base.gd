extends RigidBody2D

@export var MAX_HEALTH = 10
var health = MAX_HEALTH

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func take_damage(damage: float) -> void:
	health = clamp(health - damage, 0, MAX_HEALTH)
	if not health:
		get_parent().remove_child(self)
