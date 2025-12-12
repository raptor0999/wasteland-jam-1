extends Area2D

@onready var anim = $BatAnimation
@onready var hitbox: CollisionShape2D = $CollisionShape2D
@onready var bat_miss: AudioStreamPlayer = $Miss
@export var bat_smoke: PackedScene
var blocked = false
var zombie = false
var is_swinging = false
var points = 0
@export var score: Label
@export var timer: Label
var time = 60
var speed := 500
var zombie_hit: Area2D
var use_mouse := false

#$AnimatedSprite2D.play("swing")

func _ready():
	add_to_group("bat")
	hitbox.disabled = true
	self.area_entered.connect(_on_area_entered)
	points = 0
	var temp = bat_smoke.instantiate()
	temp.queue_free()
	
func _process(delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if use_mouse:
		position = get_global_mouse_position()
		
	if not use_mouse:
		var input_vector := Vector2.ZERO
		if Input.is_key_pressed(KEY_W):
			input_vector.y -= 1
		if Input.is_key_pressed(KEY_S):
			input_vector.y += 1
		if Input.is_key_pressed(KEY_A):
			input_vector.x -= 1
		if Input.is_key_pressed(KEY_D):
			input_vector.x += 1
		input_vector = input_vector.normalized()
		position += input_vector * speed * delta
	
	if(zombie):
		if(blocked):
			print("add 0 points")
		if not blocked:
			#print("add 10 points")
			points += 10
			zombie_hit.flash_red()
			var smoke = bat_smoke.instantiate()
			smoke.global_position = global_position
			get_tree().current_scene.add_child(smoke)
			smoke.emitting = true
			
		
		zombie = false
		blocked = false
		
	time -= delta
	timer.text = "Time Left: " + str(int(time))
	score.text = "Score: " + str(points) + "/350"
	
	if(time <= 0):
		score.text = "Game Over!"
		await get_tree().create_timer(1.5).timeout
		get_tree().reload_current_scene()
	
	if(points >= 350):
		score.text = "You Win!"
		await get_tree().create_timer(1.5).timeout
		get_tree().reload_current_scene()
		
	
func _input(event: InputEvent) -> void:
	if use_mouse:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			blocked = false
			zombie = false
			#print("set block false")
			swing()
			
	if not use_mouse:
		if event is InputEventKey and event.pressed and event.keycode == KEY_ENTER:
			blocked = false
			zombie = false
			#print("set block false")
			swing()
		
	if event is InputEventKey and event.pressed and event.keycode == KEY_TAB:
		use_mouse = !use_mouse
	
		
		
func swing():
	
	is_swinging = true
	bat_miss.play()
	anim.play("swing")
	await get_tree().create_timer(0.12).timeout
	hitbox.disabled = false
	
	
	await get_tree().create_timer(0.08).timeout
	hitbox.disabled = true
	anim.play("default")
	
	await anim.animation_finished
	is_swinging = false
	
func _on_area_entered(area: Area2D) -> void:
	if hitbox.disabled:
		return
		
	if area.is_in_group("zombies"):
		zombie = true
		zombie_hit = area
		#print("zombie")
		
	if area.is_in_group("blockers"):
		blocked = true
		#print("blocked")
