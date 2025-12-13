extends Area2D

@export var speed: float = 265
var velocity := Vector2(1, 1).normalized()
@export var percentage: Label
var progress: float = 0
var inside = false

func _ready():
	connect("area_entered", Callable(self, "_on_area_entered"))
	connect("area_exited", Callable(self, "_on_area_exited"))
	
func _process(delta):
	position += velocity * speed * delta

	if position.x < -500 or position.x > 500:
		velocity.x *= -1

	if position.y < -150 or position.y > 150:
		velocity.y *= -1
		
	
		
	if inside:
		progress += 0.14
	if not inside:
		if progress > 0:
			progress -= 0.19
	
	if progress < 100:
		percentage.text = "Progress: " + str(snapped(progress, 0.1)) + "%"
		
	if progress > 100:
		progress = 100
		percentage.text = "You Win!"
		inside = true
		await get_tree().create_timer(1).timeout
		get_tree().reload_current_scene()
		
	

func _on_area_entered(area: Area2D) -> void:
	inside = true

func _on_area_exited(area: Area2D) -> void:
	if progress < 100:
		inside = false
