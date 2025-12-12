extends Sprite2D

@export var pulse_scale: float = 1.15  
@export var pulse_speed: float = 0.6   

func _ready():
	var tween = create_tween()
	tween.set_loops() 

	tween.tween_property(self, "scale",
		Vector2(pulse_scale, pulse_scale), pulse_speed).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "scale",
		Vector2.ONE, pulse_speed).set_trans(Tween.TRANS_SINE)
