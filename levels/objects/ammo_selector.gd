extends Control

var ammo = null
var shard_mask = 0b000000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Core.pressed.connect(_on_core_button_pressed)
	$Shard1.pressed.connect(_on_shard_1_button_pressed)
	$Shard2.pressed.connect(_on_shard_2_button_pressed)
	$Shard3.pressed.connect(_on_shard_3_button_pressed)
	$Shard4.pressed.connect(_on_shard_4_button_pressed)
	$Shard5.pressed.connect(_on_shard_5_button_pressed)
	$Shard6.pressed.connect(_on_shard_6_button_pressed)
	$Shard1.hide()
	$Shard2.hide()
	$Shard3.hide()
	$Shard4.hide()
	$Shard5.hide()
	$Shard6.hide()
	var shard_mask_copy = shard_mask
	var index = 1
	while shard_mask_copy:
		if shard_mask_copy & 0b1:
			get_node('Shard' + str(index)).show()
		shard_mask_copy >>= 1
		index += 1

func update(shard_index: int) -> void:
	shard_mask |= 1 << (shard_index - 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_core_button_pressed() -> void:
	get_parent().reload(load('res://levels/objects/ammo_0.tscn'))


func _on_shard_1_button_pressed() -> void:
	get_parent().reload(load('res://levels/objects/ammo_1.tscn'))


func _on_shard_2_button_pressed() -> void:
	get_parent().reload(load('res://levels/objects/ammo_2.tscn'))


func _on_shard_3_button_pressed() -> void:
	get_parent().reload(load('res://levels/objects/ammo_3.tscn'))


func _on_shard_4_button_pressed() -> void:
	get_parent().reload(load('res://levels/objects/ammo_4.tscn'))


func _on_shard_5_button_pressed() -> void:
	get_parent().reload(load('res://levels/objects/ammo_5.tscn'))


func _on_shard_6_button_pressed() -> void:
	get_parent().reload(load('res://levels/objects/ammo_6.tscn'))
