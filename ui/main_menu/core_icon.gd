extends TextureButton


var passed_mask = 0
var mask = 0b111111

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func update(level: int) -> void:
	print("Generating new core image")
	passed_mask |= 1 << (level - 1)
	var passed_mask_copy = passed_mask
	var index = 1
	while passed_mask_copy:
		if passed_mask_copy & 0b1:
			get_node('Shard' + str(index)).show()
		passed_mask_copy >>= 1
		index += 1

	if passed_mask == mask:
		print("Enabling Core")
		disabled = false
