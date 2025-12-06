extends Control

@onready var music : AudioStreamPlayer = $Music
@onready var click_sound : AudioStreamPlayer = $Click

var crosshair = load("res://assets/art/ui/42.png")

func _on_texture_button_pressed() -> void:
	click_sound.play()
	hide()
	var level = load("res://scenes/world/level_2.tscn")
	#var player = load("res://scenes/characters/player/player.tscn")
	var level_instance = level.instantiate()
	#var player_instance = player.instantiate()
	get_node("/root/Main/Level").add_child(level_instance)
	#get_node("/root/Main").add_child(player_instance)
	music.stop()
	Input.set_custom_mouse_cursor(crosshair)

func _on_texture_button_2_pressed() -> void:
	click_sound.play()

func _on_texture_button_3_pressed() -> void:
	click_sound.play()
	var credits_menu = get_parent().get_node("Credits Menu")
	credits_menu.show()
	music.stop()

func _on_texture_button_4_pressed() -> void:
	click_sound.play()

func _on_draw() -> void:
	music.play()
