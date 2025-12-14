extends Control

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("switch_games"):
		get_tree().change_scene_to_file("res://scenes/minigames/whack_a_zombie/whack_a_zombie.tscn")
		
	if Input.is_action_just_pressed("next_difficult_scene"):
		if is_instance_valid(get_tree()) and str(get_tree().get_current_scene().get_path()) == "/root/ShootingGallery1":
			get_tree().change_scene_to_file("res://scenes/minigames/shooting_gallery/shooting_gallery_lvl2.tscn")
		if is_instance_valid(get_tree()) and str(get_tree().get_current_scene().get_path()) == "/root/ShootingGallery2":
			get_tree().change_scene_to_file("res://scenes/minigames/shooting_gallery/shooting_gallery_lvl3.tscn")
		if is_instance_valid(get_tree()) and str(get_tree().get_current_scene().get_path()) == "/root/ShootingGallery3":
			get_tree().change_scene_to_file("res://scenes/minigames/shooting_gallery/shooting_gallery_lvl1.tscn")
			
	if Input.is_action_just_pressed("exit"):
		exit()
			
func exit():
	get_parent().get_parent().get_node("Player").process_mode = Node.PROCESS_MODE_INHERIT
	get_parent().get_parent().get_node("Player").visible = true
	get_parent().get_parent().get_node("Music").process_mode = Node.PROCESS_MODE_INHERIT
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_node("/root/Main/UI/HUD").find_child("ShootProgressBar", true, false).value = Global.shootingGalleryComplete
	get_node("/root/Main/UI/HUD").find_child("LivesProgressBar", true, false).value = Global.attemptsRemaining
	get_node("/root/Main/UI/HUD").visible = true
	queue_free()
	
	if Global.isWin():
		get_node("/root/Main").win()
	elif Global.isLose():
		get_node("/root/Main").lose()
