extends Sprite2D

@export var hide_system_cursor: bool = true  
@export var clamp_to_screen: bool = true    

func _ready() -> void:
	if hide_system_cursor:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)  

func _process(_delta: float) -> void:
	
	var mouse_pos = get_global_mouse_position()

	if clamp_to_screen:
		var screen_size = get_viewport_rect().size
		mouse_pos.x = clamp(mouse_pos.x, 0, screen_size.x)
		mouse_pos.y = clamp(mouse_pos.y, 0, screen_size.y)

   
	global_position = mouse_pos
