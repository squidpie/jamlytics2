extends Node2D


var linear_velocity = 0
var angular_velocity = 0
var launched = false
var mass = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mass = $RigidBody2D.mass


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if launched:
		state.set_linear_velocity(linear_velocity)
		state.set_angular_velocity(angular_velocity)
		launched = false


func launch(setter_linear_velocity: Vector2, setter_angular_velocity: float) -> void:
	linear_velocity = setter_linear_velocity
	angular_velocity = setter_angular_velocity
	$RigidBody2D.freeze = false
	launched = true


func despawn() -> void:
	var global_parent = find_parent("LauncherHand")
	for body: Node in $RigidBody2D.get_colliding_bodies():
		if body.is_class('RigidBody2D'):
			body.sleeping = false
	global_parent.get_parent().current_ammo = null
	global_parent.call_deferred("remove_child", self)
