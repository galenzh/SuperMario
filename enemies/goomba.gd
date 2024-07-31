extends CharacterBody2D

@export var speed = 50
@export var gravity_value = 1000
@onready var raycast_forward = $RayCast2D_Forward
@onready var raycast_ground = $RayCast2D_Ground
@onready var sprite = $AnimatedSprite2D

var direction = Vector2.LEFT

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
	sprite.flip_h = !sprite.flip_h
