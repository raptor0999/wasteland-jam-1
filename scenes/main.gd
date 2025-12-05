extends Node2D

@onready var main_menu : Control = $"UI/Main Menu"
@onready var pause_menu : Control = $"UI/Pause Menu"

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		if pause_menu.visible:
			pause_menu.close_sound.play()
			pause_menu.hide()
		else:
			pause_menu.open_sound.play()
			pause_menu.show()
