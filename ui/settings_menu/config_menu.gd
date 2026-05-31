extends Control

var audio_engine = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_engine = get_node('/root/Main/AudioEngine')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_close_button_pressed() -> void:
	hide()


func _on_volume_slider_value_changed(value: float) -> void:
	audio_engine.set_volume(value)


func _on_mute_check_box_toggled(toggled_on: bool) -> void:
	audio_engine.set_mute(toggled_on)


func _on_reset_button_pressed() -> void:
	$VolumeSlider.value = 0
	$MuteCheckBox.button_pressed = false
	$SFXVolumeSlider.value = 0
	$SFXMute.button_pressed = false


func _on_play_tutorial_pressed() -> void:
	hide()


func _on_sfx_volume_slider_value_changed(value: float) -> void:
	audio_engine.set_fx_volume(value)


func _on_sfx_volume_slider_drag_ended(value_changed: bool) -> void:
	if not value_changed:
		return
	audio_engine.play_fx("bounce")


func _on_sfx_mute_toggled(toggled_on: bool) -> void:
	audio_engine.set_fx_mute(toggled_on)
	audio_engine.play_fx("click")
