extends Node2D
@onready var animation_player = $AnimationPlayer
var is_broken = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("player") and not is_broken:
		_on_brick_hit()
		
func _on_brick_hit():
	if not is_broken:
		animation_player.play("bounce")
		# is_broken = true
