extends Area2D

@export var goToLevel = "level_2"
@export var spawnPoint = "FromLevel2"
@export var miniGameScene : String = ""
@export var miniGame : String = ""

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if not miniGameScene.is_empty():
			var spawnBackPoint = get_node("SpawnBack").position
			get_node("/root/Main").loadGameScene(miniGameScene, spawnBackPoint)
		else:
			get_node("/root/Main").loadLevel(goToLevel, spawnPoint, "World2")


func _on_area_entered(area: Area2D) -> void:
	if area.name == "PlayerShape":
		if not miniGameScene.is_empty():
			if miniGame == "shoot" and not Global.shootingGalleryComplete:
				var spawnBackPoint = get_node("SpawnBack").global_position
				get_node("/root/Main").loadGameScene(miniGameScene, spawnBackPoint)
			if miniGame == "whack" and not Global.zombieWhackComplete:
				var spawnBackPoint = get_node("SpawnBack").global_position
				get_node("/root/Main").loadGameScene(miniGameScene, spawnBackPoint)
			if miniGame == "piss" and not Global.clownMouthComplete:
				var spawnBackPoint = get_node("SpawnBack").global_position
				get_node("/root/Main").loadGameScene(miniGameScene, spawnBackPoint)
		else:
			get_node("/root/Main").loadLevel(goToLevel, spawnPoint, "World2")
