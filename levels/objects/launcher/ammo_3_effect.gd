extends Node2D


var activated = false
var angle = 0
var targets = {}

var EFFECT_SIZE = 75
var EFFECT_POWER = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var parent: RigidBody2D = get_parent()
	parent.body_entered.connect(_on_ammo_collision)


func calcuate_damage() -> void:
	print("Triggering Ammo 3 Effect")
	for key in targets.keys():
		targets[key].take_damage(EFFECT_POWER)
	find_parent("AmmoBase").despawn()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if activated:
		while angle < 2 * PI:
			if $RayCast2D.is_colliding():
				var object = $RayCast2D.get_collider()
				targets.set(object.get_rid(), object)
			$RayCast2D.target_position = Vector2(EFFECT_SIZE*sin(angle), EFFECT_SIZE*cos(angle))
			$RayCast2D.force_raycast_update()
			angle += delta
		activated = false
		call_deferred("calcuate_damage")


func _on_ammo_collision(body: Node) -> void:
	if find_parent(body.name):
		return
	activated = true
