extends CharacterBody2D


@onready var sprite2D = $AnimatedSprite2D
@onready var LeftDamageBox =$L_damage_Box
@onready var RightDamageBox =$R_damage_Box
@onready var interactlabel = $E_label
@export var health: float
@export var stress: float
@export var speed = 300
@export var damage = 10
var inventary :Array[Objet]


func _ready() -> void:
	LeftDamageBox.area_entered.connect(VerifyArea)
	RightDamageBox.area_entered.connect(VerifyArea)

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
	
	if Input.is_action_pressed("Attack"): # si ont presse sur le boutton attack 
		print("attack!!")
		Attack()
		
# VERIFYING AREA FUNCTION /////////////////////////////

func VerifyArea(area: Area2D):
	var intrus= area.get_parent()
	if intrus.is_in_group("enemy"):
		print("Enemy en vue")
	elif intrus.is_in_group("Objet"):
		print("ooh un objet")

# ATTACKING FUNCTION //////////////////////////////

func Attack(enemy:Node2D = null):
	if enemy != null:
		enemy.health-=damage
	
# RAMASSER FUNCTION //////////////////////

func ramasser(objet: Objet):
	inventary.append(objet)
	print("item picked up go check it !!")

	
func CanInteract():
	interactlabel.show()
func CantInteract():
	interactlabel.hide()
	
	
