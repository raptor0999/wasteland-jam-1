extends Node2D

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("switch_games"):
		get_tree().change_scene_to_file("res://scenes/minigames/clown_mouth/clown_mouth.tscn")
	if Input.is_action_just_pressed("exit"):
		exit()
			
func exit():
	get_parent().get_parent().get_node("Player").process_mode = Node.PROCESS_MODE_INHERIT
	get_parent().get_parent().get_node("Player").visible = true
	get_parent().get_parent().get_node("Music").process_mode = Node.PROCESS_MODE_INHERIT
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_node("/root/Main/UI/HUD").find_child("WhackProgressBar", true, false).value = Global.zombieWhackComplete
	get_node("/root/Main/UI/HUD").find_child("LivesProgressBar", true, false).value = Global.attemptsRemaining
	get_node("/root/Main/UI/HUD").visible = true
	queue_free()
	
	if Global.isWin():
		get_node("/root/Main").win()
	elif Global.isLose():
		get_node("/root/Main").lose()
