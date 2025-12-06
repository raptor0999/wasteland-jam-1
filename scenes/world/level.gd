extends Node2D

@export var goToLevel = "level_2"

func _on_teleport_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var level_node = get_parent()
		for l in level_node.get_children():
			l.queue_free()
			
		var level = load("res://scenes/world/" + goToLevel + ".tscn")
		var level_instance = level.instantiate()
		level_node.add_child(level_instance)
