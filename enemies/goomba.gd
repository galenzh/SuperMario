extends CharacterBody2D

@export var speed = 50
@export var gravity_value = 1000
@onready var raycast_forward = $RayCast2D_Forward
@onready var raycast_ground = $RayCast2D_Ground
@onready var animated_sprite = $AnimatedSprite2D
@onready var timer = $Timer

var direction = Vector2.LEFT
var is_died = false

func _ready():
	pass

func _physics_process(delta):
	# 应用重力
	velocity.y += gravity_value * delta

	# 检测前方是否有障碍物
	if raycast_forward.is_colliding():
		change_direction()

	# 移动敌人
	velocity.x = direction.x * speed
	move_and_slide()

func change_direction():
	# 改变方向
	direction = -direction

	# 翻转 RayCast2D 的方向
	raycast_forward.target_position.x = -raycast_forward.target_position.x

	# 翻转敌人的图像方向
	animated_sprite.flip_h = !animated_sprite.flip_h


func _on_area_2d_body_body_entered(body):
	if body.is_in_group("player") and not is_died:
		print('player died') # Replace with function body.


func _on_area_2d_head_body_entered(body):
	if body.is_in_group("player") and not is_died:
		is_died = true
		direction = Vector2.ZERO;
		animated_sprite.play("die")
		body.jump_small()
		timer.start()
		print('goomba died')


func _on_timer_timeout():
	queue_free()
