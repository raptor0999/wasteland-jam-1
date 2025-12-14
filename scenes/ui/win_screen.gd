extends Control

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://scenes/main.tscn")
