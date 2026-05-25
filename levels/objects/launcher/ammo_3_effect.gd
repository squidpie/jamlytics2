extends Node2D


var activated = false
var completed = false
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
	$AnimatedSprite2D.play("splash")
	var ammo_parent = find_parent("AmmoBase")
	get_parent().hide()
	reparent(ammo_parent)
	for key in targets.keys():
		targets[key].take_damage(EFFECT_POWER)
	await get_tree().create_timer(1).timeout
	ammo_parent.despawn()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if activated:
		activated = false
		while angle < 2 * PI:
			if $RayCast2D.is_colliding():
				var object = $RayCast2D.get_collider()
				targets.set(object.get_rid(), object)
			$RayCast2D.target_position = Vector2(EFFECT_SIZE*sin(angle), EFFECT_SIZE*cos(angle))
			$RayCast2D.force_raycast_update()
			angle += delta
		completed = true
		call_deferred("calcuate_damage")


func _on_ammo_collision(body: Node) -> void:
	if completed or find_parent(body.name):
		return
	activated = true
