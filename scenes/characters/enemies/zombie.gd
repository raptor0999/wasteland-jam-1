extends CharacterBody2D

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	anim.play("idle-downleft")

func _on_hitbox_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("Area2D clicked!")
		anim.play("hit-downleft")

func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.animation == "hit-downleft":
		anim.play("idle-downleft")
