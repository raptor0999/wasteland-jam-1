extends Node2D

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("switch_games"):
		get_tree().change_scene_to_file("res://scenes/minigames/shooting_gallery/shooting_gallery.tscn")
