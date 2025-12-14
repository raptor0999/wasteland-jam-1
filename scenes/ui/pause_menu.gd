extends Control

@onready var click_sound : AudioStreamPlayer = $Click
@onready var open_sound : AudioStreamPlayer = $Open
@onready var close_sound : AudioStreamPlayer = $Close

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		if visible:
			print_debug(visible)
			hide()
			get_tree().paused = false
			get_node("/root/Main/").musicPlayer.volume_db = 0.0
		else:
			print_debug(visible)
			show()
			get_tree().paused = true
			get_node("/root/Main/").musicPlayer.volume_db = -12.0
			
	if Input.is_action_just_pressed("ui_accept") and visible:
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_texture_button_pressed() -> void:
	click_sound.play()
	hide()

func _on_texture_button_2_pressed() -> void:
	click_sound.play()

func _on_texture_button_3_pressed() -> void:
	get_tree().paused = false
	click_sound.play()
	get_tree().change_scene_to_file("res://scenes/main.tscn")
