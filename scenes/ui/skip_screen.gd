extends Control

@export var win = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not win:
			SceneManager.retry_last()
			
		else:
			SceneManager.load_next()
