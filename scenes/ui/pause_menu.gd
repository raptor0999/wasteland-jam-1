extends Control

@onready var click_sound : AudioStreamPlayer = $Click
@onready var open_sound : AudioStreamPlayer = $Open
@onready var close_sound : AudioStreamPlayer = $Close

func _on_texture_button_pressed() -> void:
	click_sound.play()
	hide()

func _on_texture_button_2_pressed() -> void:
	click_sound.play()

func _on_texture_button_3_pressed() -> void:
	click_sound.play()
