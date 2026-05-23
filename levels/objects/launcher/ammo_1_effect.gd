extends Node


var EFFECT_STRENGTH = Vector2(65, 65)
var activated = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_rigid_body_2d_sleeping_state_changed() -> void:
	if activated:
		return
	activated = true
	print("Triggering Ammo 1 Effect")
	for target: RigidBody2D in $Area2D.get_overlapping_bodies():
		target.apply_impulse(EFFECT_STRENGTH, get_parent().position)
	var global_parent = find_parent("LauncherHand")
	var local_parent = find_parent("AmmoBase")
	global_parent.get_parent().current_ammo = null
	global_parent.call_deferred("remove_child", local_parent)
