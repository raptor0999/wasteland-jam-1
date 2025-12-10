extends Area2D

@export var up_pos: Vector2
@export var down_pos: Vector2

var up_time := 0.6
var down_time := 0.4
var is_up = false

func _ready():
	global_position = down_pos
	randomize()
	start_pop()

func start_pop():
	while true:
		await get_tree().create_timer(randf_range(0.5, 1.5)).timeout
		pop_up()
		await get_tree().create_timer(randf_range(0.4, 0.9)).timeout
		pop_down()
		
func pop_up():
	if is_up: return
	is_up = true
	var tween = create_tween()
	tween.tween_property(self, "global_position", up_pos, up_time)
	
func pop_down():
	if not is_up: return
	is_up = false
	var tween = create_tween()
	tween.tween_property(self, "global_position", down_pos, down_time)
