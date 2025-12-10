extends Area2D

@onready var anim = $BatAnimation
@onready var hitbox: CollisionShape2D = $CollisionShape2D
var is_swinging = false

#$AnimatedSprite2D.play("swing")

func _ready():
	hitbox.disabled = true
	self.area_entered.connect(_on_area_entered)
	
func _process(delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	position = get_global_mouse_position()
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		swing()
		
func swing():
	is_swinging = true
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
	
	if not area.is_in_group("zombies"):
		print("miss")
		return
			
	for blocker in get_tree().get_nodes_in_group("blockers"):
		if self.overlaps_area(blocker):  
			print("blocked!")
			return
		
		print("hit!")
	#add points
