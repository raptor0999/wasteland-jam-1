extends Node

var scene_order := [
	"res://scenes/minigames/shooting_gallery/shooting_gallery_lvl1.tscn",
	"res://scenes/minigames/shooting_gallery/shooting_gallery_lvl2.tscn",
	"res://scenes/minigames/shooting_gallery/shooting_gallery_lvl3.tscn",
	"res://scenes/ui/win_screen.tscn",
	"res://scenes/minigames/whack_a_zombie/whack_a_zombie.tscn",
	"res://scenes/minigames/clown_mouth/clown_mouth.tscn"
]

var game_over_scene := "res://scenes/ui/lose_screen.tscn"
var win_scene := "res://scenes/ui/win_screen.tscn"

var current_index := 0
var last_played_index := 0


func load_next():
	last_played_index = current_index
	current_index += 1
	
	if current_index >= scene_order.size():
		print("All minigames completed!")
		restart_all()
		return
	
	get_tree().change_scene_to_file(scene_order[current_index])
	
func load_game_over():
	last_played_index = current_index
	get_tree().change_scene_to_file(game_over_scene)
	
func load_win():
	last_played_index = current_index
	get_tree().change_scene_to_file(win_scene)
	
func retry_last():
	if current_index <= 2:
		last_played_index = 0
		current_index = 0
	get_tree().change_scene_to_file(scene_order[last_played_index])
	
func restart_all():
	current_index = 0
	last_played_index = 0
	get_tree().change_scene_to_file(scene_order[0])
