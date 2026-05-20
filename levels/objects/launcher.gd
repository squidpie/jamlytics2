extends Control

var dragging = false
var launched = false

var diff_position = Vector2.ZERO

var ammo_scene = preload("res://levels/objects/ammo_base.tscn")
var current_ammo = null

var MAX_DRAG = 475
var PLAYER_VELOCITY_FACTOR = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$LauncherHand/Control.gui_input.connect(_on_gui_input)


func _process(_delta: float) -> void:
	if not current_ammo:
		reload(ammo_scene)

	if dragging:
		var mouse_position = get_local_mouse_position()
		var radius = mouse_position.distance_to($Anchor.position)
		if radius < MAX_DRAG:
			$LauncherHand.transform.origin = mouse_position
			diff_position = $Anchor.position - $LauncherHand.transform.origin


func _physics_process(delta: float) -> void:
	if launched:
		var linear_velocity = diff_position.normalized() * \
							  current_ammo.mass * \
							  get_local_mouse_position().distance_to($Anchor.position) * \
							  PLAYER_VELOCITY_FACTOR
		
		var angular_velocity = (linear_velocity.angle() - rotation) * delta
		current_ammo.launch(linear_velocity, angular_velocity)
		launched = false

		#if launched:
		#var player_mass = $PlayerCore.mass
		#for child in $PlayerCore.get_children():
			#var child_mass = child.get("mass")
			#if child_mass != null:
				#player_mass += child_mass
		#var linear_velocity = diff_position.normalized() *  \
							  #distance * \
							  #player_mass *\
							  #PLAYER_VELOCITY_FACTOR
		#var rotation = $PlayerCore.rotation
		#var delta = 1 / state.get_step()
		#var angular_velocity = (linear_velocity.angle() - rotation) * delta
		#state.set_linear_velocity(linear_velocity)
		#state.set_angular_velocity(angular_velocity)
		#launched = false


func reload(scene: PackedScene) -> void:
	current_ammo = scene.instantiate()
	current_ammo.position = $LauncherHand/AttachMarker2D.position
	current_ammo.get_node('RigidBody2D').freeze = true
	$LauncherHand.add_child(current_ammo)


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if dragging and event.is_released():
			launched = true
			dragging = false
		else:
			dragging = true
