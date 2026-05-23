extends Node2D

var SHRAPNEL_COUNT_FACTOR = 30

var activated = false
var completed = false
var shrapnel_scene = preload("res://levels/objects/launcher/shrapnel.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if activated:
		activated = false
		completed = true
		var angle = 0
		while angle < 2 * PI:
			var shrapnel:RigidBody2D = shrapnel_scene.instantiate()
			shrapnel.add_constant_force(Vector2(5000*sin(angle), 5000*cos(angle)))
			add_child(shrapnel)
			angle += SHRAPNEL_COUNT_FACTOR*delta


func _on_rigid_body_2d_sleeping_state_changed() -> void:
	if completed:
		return
	activated = true
