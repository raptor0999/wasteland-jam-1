extends Area2D

@export var acceleration: float = 800.0
@export var drag: float = 1.5  
var velocity: Vector2 = Vector2.ZERO

func _process(delta):
	var target = get_global_mouse_position()
	var direction = (target - position).normalized()

	velocity += direction * acceleration * delta

	velocity *= 1.0 - drag * delta

	position += velocity * delta
