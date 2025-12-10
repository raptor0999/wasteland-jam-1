extends Area2D

@onready var explosion_scene = preload("res://scenes//minigames//shooting_gallery//target_explosion.tscn")
@export var speed: float = 800.0
var direction: Vector2 = Vector2.ZERO  
var gun

func _ready() -> void:
	$CollisionShape2D.disabled = false
	connect("area_entered", Callable(self, "_on_area_entered"))

func _process(delta: float) -> void:
	
	position += direction * speed * delta

	
	var screen_size = get_viewport_rect().size
	if position.x < 0 or position.x > screen_size.x or position.y < 0 or position.y > screen_size.y:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if position.x > 240 or position.x < 1300:
		if area.is_in_group("clowns"):
			print("clown")
			var explosion = explosion_scene.instantiate()
			explosion.global_position = global_position
			get_tree().current_scene.add_child(explosion)
			explosion.emitting = true
			queue_free()
			area.get_parent().queue_free()
			
		if area.is_in_group("zombies"):
			print("zombie")
			var explosion = explosion_scene.instantiate()
			explosion.global_position = global_position
			get_tree().current_scene.add_child(explosion)
			explosion.emitting = true
			queue_free()
			area.get_parent().queue_free()
			if gun:
				gun.lose_life()
