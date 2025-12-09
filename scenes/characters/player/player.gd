extends CharacterBody2D

@onready var animatedSprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var footstepsSFX : AudioStreamPlayer = $Footsteps
@onready var shotSFX : AudioStreamPlayer = $GunShot
@onready var gasMaskSFX : AudioStreamPlayer = $Gasmask
@onready var matchesSFX : AudioStreamPlayer = $Matches
@onready var light : PointLight2D = $Light

var speed = 200  # speed in pixels/sec
var is_shooting = false
var player_action = "idle"
var player_dir = "upright"

func _ready() -> void:
	animatedSprite.play("idle-upright")

func _physics_process(delta):
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("left"):
		direction = Vector2(-1, -1)
	elif Input.is_action_pressed("right"):
		direction = Vector2(1, 1)
	elif Input.is_action_pressed("up"):
		direction = Vector2(1, -1)
	elif Input.is_action_pressed("down"):
		direction = Vector2(-1, 1)
		
	#var direction = Input.get_vector("left", "right", "up", "down")
	if not is_shooting:
		if Input.is_action_pressed("run"):
			velocity = direction * speed * 3
		else:
			velocity = direction * speed
	
		if velocity.length() > 0.1:
			player_action = "walk"
			if velocity.x < 0:
				if velocity.y > 0:
					player_dir = "downleft"
					#light.rotation_degrees = 180
					#light.offset.x = 250
					#light.offset.y = -200
				else:
					player_dir = "upleft"
					#light.rotation_degrees = 270
					#light.offset.x = 300
					#light.offset.y = -250
			else:
				if velocity.y > 0:
					player_dir = "downright"
					#light.rotation_degrees = 90
					#light.offset.x = 200
					#light.offset.y = -250
				else:
					player_dir = "upright"
					#light.rotation_degrees = 0
					#light.offset.x = 250
					#light.offset.y = -300
		else:
			player_action = "idle"
			
		if Input.is_action_just_pressed("shoot"):
			velocity = Vector2.ZERO
			player_action = "sg"
			is_shooting = true
			shotSFX.play()
			animatedSprite.play(player_action + "-" + player_dir)
			
	if not is_shooting:
		animatedSprite.play(player_action + "-" + player_dir)
		
	if player_action == "walk":
		if animatedSprite.frame == 3 or animatedSprite.frame == 7:
			footstep()

	move_and_slide()
	
	if Input.is_action_just_pressed("gas_mask") and not gasMaskSFX.playing:
		gasMaskSFX.play()
		
	if Input.is_action_just_pressed("matches") and not matchesSFX.playing:
		matchesSFX.play()

func _on_animated_sprite_2d_animation_finished() -> void:
	if animatedSprite.animation == "sg-" + player_dir:
		is_shooting = false
		player_action = "idle"

func footstep():
	if not footstepsSFX.playing:
		footstepsSFX.play()
