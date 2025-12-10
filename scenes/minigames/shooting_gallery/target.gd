extends Sprite2D

@export var speed: float = 200.0          
@export var left_boundary: float = -50.0  
@export var right_start: float = 1300.0   
@export var right_boundary: float = 1300.0
@export var left_start: float = -50.0
@export var spacing: float = 300.0        
@export var move_right: bool = false

func _ready() -> void:
	if get_parent():
		var index = get_parent().get_children().find(self)
		position.x += spacing * index
		
func _process(delta: float) -> void:
	if move_right:
		position.x += speed * delta
	else:
		position.x -= speed * delta

	
	if position.x < left_boundary:
		position.x = right_start
		
	if position.x > right_boundary:
		position.x = left_start
		
