extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

const MAX_SPEED = 200.0
const ACCELERATION = 300.0
const SPRINT_MULTIPLIER = 1.2  # 加速按键时的速度倍数
const DECELERATION = 200.0
const JUMP_VELOCITY = -350.0
const MAX_FALL_SPEED = 800.0

var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
const States = { "SMALL": "small", "BIG": "big", "FIRE": "fire" }
var state = States.SMALL # 角色初始状态

func _physics_process(delta):
	var direction = Input.get_axis("move_left", "move_right")
	var sprinting = Input.is_action_pressed("fire")  # 加速按键
	# Handle jumping.
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
	
	# Handle horizontal movement with acceleration and deceleration.
	if direction != 0:
		var target_speed = MAX_SPEED
		if sprinting:
			target_speed *= SPRINT_MULTIPLIER
		
		velocity.x = move_toward(velocity.x, direction * target_speed, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)
	
	# Apply gravity if not on the floor.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		# Cap the fall speed.
		if velocity.y > MAX_FALL_SPEED:
			velocity.y = MAX_FALL_SPEED
	
	# Move and slide the character.
	move_and_slide()
	
	# Update the animation based on the velocity.
	if is_on_floor():
		if velocity.x != 0:
			if direction * velocity.x < 0:
				animated_sprite.play(state + "_stop")
			else:
				animated_sprite.play(state + "_run")
			animated_sprite.flip_h = velocity.x < 0
		else:
			animated_sprite.play(state + "_idle")
	else:
		animated_sprite.play(state + "_jump")
	

# 踩死敌人后轻微跳动
func jump_small():
	velocity.y = -140
