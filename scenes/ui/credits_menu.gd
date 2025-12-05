extends Control

@onready var click_sound : AudioStreamPlayer = $Click
@onready var open_sound : AudioStreamPlayer = $Open
@onready var close_sound : AudioStreamPlayer = $Close
@onready var music : AudioStreamPlayer = $Music

func _on_texture_button_pressed() -> void:
	click_sound.play()
	music.stop()
	hide()
	get_parent().get_node("Main Menu").music.play()

func _on_draw() -> void:
	music.play()
