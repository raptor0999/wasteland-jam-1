extends GPUParticles2D

@export var target: Area2D 
@export var turn_speed := 20
@export var particle_speed := 1200.0  

var mat: ParticleProcessMaterial


func _ready():
	mat = process_material

func _process(delta):
	if not target:
		return
	
	var target_pos = target.global_position
	var target_angle = (target_pos - global_position).angle()
	target_angle += deg_to_rad(90)
	
	rotation = lerp_angle(rotation, target_angle, delta * turn_speed)

	var distance = global_position.distance_to(target_pos) - 85.0
	lifetime = distance / particle_speed
