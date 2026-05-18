extends Node

var dragging = false
var launched = false
var is_resetting = false
var reset_position = Vector2.ZERO
var diff_position = Vector2.ZERO
var distance = 0
var last_window_size = Vector2.ZERO

var LAUNCHER_RELATIVE_POSITION = Vector2(0.75, 0.25)
var PLAYER_VELOCITY_FACTOR = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	last_window_size = Vector2(get_viewport().get_window().size)
	freeze()
	$PlayerCore.input_event.connect(_on_player_core_input_event)
	$PlayerCore/VisibleOnScreenNotifier2D.screen_exited.connect(_on_player_exit_screen)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var window_size = Vector2(get_viewport().get_window().size)
	reset_position = window_size * (Vector2.ONE - LAUNCHER_RELATIVE_POSITION)
	if window_size != last_window_size:
		last_window_size = window_size
		is_resetting = true


func _physics_process(_delta: float) -> void:
	if dragging:
		$PlayerCore.global_transform.origin = $PlayerCore.get_global_mouse_position()

	if is_resetting:
		freeze()
		$PlayerCore.global_transform.origin = reset_position
		is_resetting = false


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if dragging:
		var player_position = $PlayerCore.global_transform.origin
		diff_position = reset_position - player_position
		distance = player_position.distance_to(reset_position)

	if launched:
		var player_mass = $PlayerCore.mass
		for child in $PlayerCore.get_children():
			var child_mass = child.get("mass")
			if child_mass != null:
				player_mass += child_mass
		var linear_velocity = diff_position.normalized() *  \
							  distance * \
							  player_mass *\
							  PLAYER_VELOCITY_FACTOR
		var rotation = $PlayerCore.rotation
		var delta = 1 / state.get_step()
		var angular_velocity = (linear_velocity.angle() - rotation) * delta
		state.set_linear_velocity(linear_velocity)
		state.set_angular_velocity(angular_velocity)
		launched = false


func hide() -> void:
	for child in get_children():
		child.hide()


func show() -> void:
	for child in get_children():
		child.show()


func reset() -> void:
	is_resetting = true


func freeze() -> void:
	$PlayerCore.freeze = true
	for child in $PlayerCore.get_children():
		var child_freeze = child.get("freeze")
		if child_freeze != null:
			child_freeze = true


func unfreeze() -> void:
	$PlayerCore.freeze = false
	for child in $PlayerCore.get_children():
		var child_freeze = child.get("freeze")
		if child_freeze != null:
			child_freeze = false


func update(fragment_id: int) -> void:
	var fragment = load("res://player/player_fragment.tscn")
	var fragment_instance: RigidBody2D = fragment.instantiate()
	var fragment_marker = get_node("PlayerCore/Fragment" + str(fragment_id) + "Marker2D")
	fragment_instance.position = fragment_marker.position
	fragment_instance.rotation = fragment_marker.rotation
	$PlayerCore.add_child(fragment_instance)

	var joint = PinJoint2D.new()
	joint.node_a = $PlayerCore.get_path()
	joint.node_b = fragment_instance.get_path()
	joint.bias = 1
	$PlayerCore.add_child(joint)
	
	joint = PinJoint2D.new()
	joint.node_a = fragment_instance.get_path()
	joint.node_b = $PlayerCore.get_path()
	joint.bias = 1
	fragment_instance.add_child(joint)


func _on_player_core_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:# and event.button_index == MOUSE_BUTTON_LEFT:
		dragging = event.pressed
		if not event.pressed:
			unfreeze()
			launched = true


func _on_player_exit_screen() -> void:
	is_resetting = true
