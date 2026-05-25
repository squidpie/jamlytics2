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


func _on_ammo_collision(body: Node) -> void:
	if activated or find_parent(body.name):
		return
	$AnimatedSprite2D.play("charged")
	var ammo_parent = find_parent("AmmoBase")
	get_parent().hide()
	call_deferred("reparent", ammo_parent)
	var bodies = $Area2D.get_overlapping_bodies()
	for target in bodies:
		if "Enemy" in target.name:
			print("Triggering Ammo 2 Effect")
			activated = true
			target.take_damage(EFFECT_STRENGTH)
			await get_tree().create_timer(1).timeout
			find_parent("AmmoBase").despawn()
			break
