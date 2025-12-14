extends CharacterBody2D

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_box : Area2D = $Hitbox
@onready var detect_box : Area2D = $DetectBox
@onready var die_sfx : AudioStreamPlayer2D = $Die
@onready var close_sfx : AudioStreamPlayer2D = $Close

func _ready() -> void:
	anim.play("idle-downleft")

func _on_hitbox_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		die()

func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.animation == "hit-downleft":
		anim.play("idle-downleft")

func die():
	if anim.animation != "die-downleft":
		anim.play("die-downleft")
	
	collision_layer = 0
	hit_box.collision_layer = 0
	detect_box.collision_layer = 0
	Global.zombiesKilled += 1.0
	get_node("/root/Main/UI/HUD").find_child("ZombieProgressBar", true, false).value = Global.zombiesKilled
	die_sfx.play()
	
	if Global.isWin():
		get_node("/root/Main").win()

func _on_detect_box_body_entered(body: Node2D) -> void:
	if not close_sfx.playing:
		close_sfx.play()
