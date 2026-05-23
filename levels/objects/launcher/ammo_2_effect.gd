extends Node2D

var EFFECT_STRENGTH = 5
var activated = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var parent: RigidBody2D = get_parent()
	parent.body_entered.connect(_on_ammo_collision)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_ammo_collision(_body: Node) -> void:
	if activated:
		return
	var bodies = $Area2D.get_overlapping_bodies()
	for target in bodies:
		if "Enemy" in target.name:
			print("Triggering Ammo 2 Effect")
			activated = true
			target.take_damage(EFFECT_STRENGTH)
			find_parent("AmmoBase").despawn()
