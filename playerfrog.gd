extends CharacterBody2D
@onready var sprite2D = $AnimatedSprite2D
@onready var LeftDamageBox =$L_damage_Box
@onready var RightamageBox =$R_damage_Box
@export var health: float
@export var stress: float
@export var speed = 300
@export var damage = 10

func _ready() -> void:
	LeftDamageBox.area_entered.connect(VerifyArea)
	RightamageBox.area_entered.connect(VerifyArea)

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
		
# VERIFYING AREA FUNCTION /////////////////////////////

func VerifyArea(area: Area2D):
	var intrus= area.get_parent()
	if intrus.is_in_group("Enemy"):
		print("Enemy en vue")
	elif intrus.is_in_group("Objet"):
		print("ooh un objet")

# ATTACKING FUNCTION //////////////////////////////
func Attack(enemy:Node2D):
	enemy.health-=damage
	
	
