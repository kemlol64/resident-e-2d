extends CharacterBody2D
@onready var sprite2D = $AnimatedSprite2D

@export var speed = 300
func _physics_process(delta: float) -> void:
	var original_scale=abs(sprite2D.scale.x)
	var direction =Vector2.ZERO
	if Input.is_action_pressed("left_walk"):
		direction.x = -1
		sprite2D.scale.x=original_scale*-1
	if Input.is_action_pressed("right_walk"):
		direction.x = 1
		sprite2D.scale.x=original_scale*1
	if Input.is_action_pressed("up_walk"):
		direction.y = -1
	if Input.is_action_pressed("down_walk"):
		direction.y = 1
	if direction.x != 0 or direction.y != 0:
		direction=direction.normalized()
	velocity=speed*direction
	move_and_slide()
		
