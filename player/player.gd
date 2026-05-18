extends Node

var dragging = false
var is_resetting = false
var reset_position = Vector2(150, 150)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	freeze()
	$PlayerCore.input_event.connect(_on_player_core_input_event)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _physics_process(_delta: float) -> void:
	if dragging:
		$PlayerCore.global_transform.origin = $PlayerCore.get_global_mouse_position()

	if is_resetting:
		$PlayerCore.global_transform.origin = reset_position
		is_resetting = false


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
	joint.node_b = $PlayerCore.get_path()
	joint.node_a = fragment_instance.get_path()
	joint.bias = 1
	fragment_instance.add_child(joint)


func _on_player_core_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:# and event.button_index == MOUSE_BUTTON_LEFT:
		dragging = event.pressed
		if not event.pressed:
			unfreeze()
