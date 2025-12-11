extends Control

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("switch_games"):
		get_tree().change_scene_to_file("res://scenes/minigames/whack_a_zombie/whack_a_zombie.tscn")
