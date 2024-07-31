extends Node2D
@onready var animated_sprite_2d = $AnimatedSprite2D # blink, diabled
@onready var animation_player = $AnimationPlayer # bounce
@onready var coin_scene = preload("res://items/coin_up.tscn") # 预加载你的金币场景
@onready var mushroom_scene = preload("res://items/mushroom-grow.tscn") # 预加载你的金币场景
var coin:Node2D = null # 用来存储金币

var is_broken = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		_on_brick_hit()
		
		
func _on_brick_hit():
	if not is_broken:
		animation_player.play("bounce")
		_create_coin()
		is_broken = true
		await get_tree().create_timer(animation_player.current_animation_length - 0.4).timeout
		animated_sprite_2d.play("disabled")
		
		
func _create_coin():
	coin = coin_scene.instantiate()
	add_child(coin)


func _on_animation_player_animation_finished(anim_name):
	if coin:
		coin.queue_free()
		coin = null
		
