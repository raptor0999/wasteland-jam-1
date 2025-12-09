extends Area2D

@export var goToLevel = "level_2"
@export var spawnPoint = "FromLevel2"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_node("/root/Main").loadLevel(goToLevel, spawnPoint, "World")
