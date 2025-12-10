extends Sprite2D

@export var bullet_scene: PackedScene
@export var crosshair: Node2D
@export var min_angle_deg: float = -165
@export var max_angle_deg: float = -15
@export var bullet_speed: float = 800.0
@export var lives_label: Label
var tree := Engine.get_main_loop() as SceneTree
var lives: int = 3

@onready var gun_shoot_sfx : AudioStreamPlayer = $Gun	

func _ready():
	var temp = bullet_scene.instantiate()
	temp.queue_free()
	
func _process(_delta: float) -> void:
	if not crosshair:
		return
		
	if crosshair.global_position.y > 500:
		return
		
	var direction = crosshair.global_position - global_position
	var angle_to_crosshair = direction.angle()
	
	var min_angle_rad = deg_to_rad(min_angle_deg)
	var max_angle_rad = deg_to_rad(max_angle_deg)
	rotation = clamp(angle_to_crosshair, min_angle_rad, max_angle_rad) + deg_to_rad(90)
	
	check_clowns_destroyed()
	
func check_clowns_destroyed() -> void:
	var targets = get_tree().get_nodes_in_group("clowns")
	if targets.is_empty():
		print("All clowns destroyed! You win!")
		await get_tree().create_timer(0.2).timeout
		lives_label.text = "You Win!"
		await tree.create_timer(0.8).timeout
		get_tree().reload_current_scene()
		

	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		shoot()
		
func shoot() -> void:
	gun_shoot_sfx.play()
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	var direction = (crosshair.global_position - global_position).normalized()
	bullet.direction = direction
	bullet.speed = bullet_speed
	bullet.gun = self
	get_tree().current_scene.add_child(bullet)
	
func lose_life():
	lives -= 1
	if lives_label:
		lives_label.text = "Lives: " + str(lives)
	if lives <= 0:
		print("You lose!")
		await get_tree().create_timer(0.5).timeout
		lives_label.text = "Game Over!"
		await get_tree().create_timer(0.8).timeout
		get_tree().reload_current_scene()
