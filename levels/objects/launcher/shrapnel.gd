extends RigidBody2D


var EFFECT_STRENGTH = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	if get_parent() == body.get_parent():
		return
	body.take_damage(EFFECT_STRENGTH)
	get_parent().call_deferred("remove_child", self)
