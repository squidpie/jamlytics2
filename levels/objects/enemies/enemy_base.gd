extends RigidBody2D

signal enemy_died

var health = 0
@export var MAX_HEALTH = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = MAX_HEALTH


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if not health:
		enemy_died.emit()
		get_parent().remove_child(self)


func take_damage(damage: float) -> void:
	health = clamp(health-damage, 0, MAX_HEALTH)


func _on_body_entered(body: Node) -> void:
	match body.get_class():
		'RigidBody2D':
			take_damage(body.mass)
		'StaticBody2D':
			take_damage(linear_velocity.length())


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	take_damage(MAX_HEALTH)
