extends Area2D

@export var clown: bool = false


func _ready() -> void:
	if clown:
		add_to_group("clowns")
	if not clown:
		add_to_group("zombies")
