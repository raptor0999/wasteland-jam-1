extends Node2D

@onready var main_menu : Control = $"UI/Main Menu"
@onready var pause_menu : Control = $"UI/Pause Menu"
@onready var player : CharacterBody2D = $Player
@onready var musicPlayer : AudioStreamPlayer = $Music

var named_tracks_dict = {}

func _ready() -> void:
	var named_tracks_stream1 : AudioStream = load("res://assets/audio/music/soundtrack-menu.mp3")
	var named_tracks_stream2 : AudioStream = load("res://assets/audio/music/soundtrack-menu-2.mp3")
	var named_tracks_stream3 : AudioStream = load("res://assets/audio/music/soundtrack-credits-2(good).mp3")
	var named_tracks_stream4 : AudioStream = load("res://assets/audio/music/IntroTrack1.mp3")
	var named_tracks_stream5 : AudioStream = load("res://assets/audio/music/soundtrack-world-open-1.mp3")
	var named_tracks_stream6 : AudioStream = load("res://assets/audio/music/DarkCarn.mp3")
	
	named_tracks_dict = {
		"Menu": named_tracks_stream1,
		"Menu2": named_tracks_stream2,
		"Credits": named_tracks_stream3,
		"Intro": named_tracks_stream4,
		"World": named_tracks_stream5,
		"World2": named_tracks_stream6,
	}
	
	musicPlayer.stream = named_tracks_dict["Menu"]
	musicPlayer.play()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		if pause_menu.visible:
			pause_menu.close_sound.play()
			pause_menu.hide()
		else:
			pause_menu.open_sound.play()
			pause_menu.show()

func loadLevel(levelName: String, spawnPointName: String, track: String = ""):
	player.process_mode = Node.PROCESS_MODE_DISABLED
	player.collision_layer = 0b00000000_00000000_00000000_00000000
	player.set_physics_process(false)
	var level_node = get_node("/root/Main/Level")
	for l in level_node.get_children():
		l.queue_free()
		
	print_debug(levelName)
	print_debug(spawnPointName)
			
	var level = load("res://scenes/world/" + levelName + ".tscn")
	var level_instance = level.instantiate()
	level_node.add_child(level_instance)
	
	#var player = load("res://scenes/characters/player/player.tscn")
	#var player_instance = player.instantiate()
	#get_node("Level/Level/PlayerNode").add_child(player_instance)
	
	
	
	player.position = level_node.find_child(spawnPointName, true, false).position
	#print_debug(level_node.find_child(spawnPointName, true, false).get_parent().name)
	
	if track == "":
		pass
	else:
		musicPlayer.stop()
		musicPlayer.stream = named_tracks_dict[track]
		musicPlayer.play()
		
	player.process_mode = Node.PROCESS_MODE_INHERIT
	player.collision_layer = 0b00000000_00000000_00000000_00000001
	player.set_physics_process(true)

func _on_main_menu_draw() -> void:
	player.process_mode = Node.PROCESS_MODE_DISABLED

func _on_main_menu_hidden() -> void:
	player.process_mode = Node.PROCESS_MODE_INHERIT

func _on_pause_menu_draw() -> void:
	player.process_mode = Node.PROCESS_MODE_DISABLED

func _on_pause_menu_hidden() -> void:
	player.process_mode = Node.PROCESS_MODE_INHERIT
