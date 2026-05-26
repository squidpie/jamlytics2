extends Node


var EFFECT_STRENGTH = Vector2(65, 65)
var activated = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_rigid_body_2d_sleeping_state_changed() -> void:
	if activated:
		return
	activated = true
	$AnimatedSprite2D.show()
	$AnimatedSprite2D.play("explosion")
	print("Triggering Ammo 1 Effect")
	for target: RigidBody2D in $Area2D.get_overlapping_bodies():
		target.apply_impulse(EFFECT_STRENGTH, get_parent().position)
	var ammo_parent = find_parent("AmmoBase")
	$AnimatedSprite2D.reparent(ammo_parent)
	get_parent().hide()
	await get_tree().create_timer(1).timeout
	ammo_parent.call_deferred("despawn")
