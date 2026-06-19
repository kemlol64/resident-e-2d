extends CharacterBody2D


@onready var sprite2D = $AnimatedSprite2D
@onready var LeftDamageBox =$L_damage_Box
@onready var RightDamageBox =$R_damage_Box
@onready var interactlabel =$E_label
@onready var GunSpawn=$GunSpawn
@export var health: float
@export var stress: float
@export var speed = 300
@export var damage = 10
@export var Armequiped: Arme
var armes = preload("res://Arme_equipe.tscn")
var balle = preload("res://ballePistol.tscn")
var inventary :Array


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
		Attack()
	if Input.is_action_just_pressed("Shout"):
		shoot()	
# VERIFYING AREA FUNCTION /////////////////////////////

func VerifyArea(area: Area2D):
	var intrus= area.get_parent()
	if intrus.is_in_group("enemy"):
		print("Enemy en vue")

# ATTACKING FUNCTION //////////////////////////////

func Attack(enemy:Node2D = null):
	if enemy != null:
		enemy.health-=damage
	
# RAMASSER FUNCTION //////////////////////

func ramasser(Objetdata: Objet=null,Armedata: Arme=null):
	print("item picked up go check it !!")

func CanInteract(InteractText:String = "[E]"):
	interactlabel.set_text(InteractText)
	interactlabel.show()
func CantInteract():
	interactlabel.hide()

var arme_instance: Node2D = null
func Equiper(ArmeData: Arme):
	Armequiped=ArmeData
	for fils in GunSpawn.get_children():
		fils.queue_free()
	var newArme=armes.instantiate()
	newArme.ArmeData=Armequiped
	newArme.global_position=GunSpawn.global_position
	GunSpawn.add_child(newArme)
	arme_instance=newArme
func shoot():
	if(Armequiped == null):
		print("pas d'arme")
	elif(Armequiped.chargeur>1):
		print("Fire !!")
		var shoutingArme=arme_instance
		var shoutedbullet=balle.instantiate()
		shoutedbullet.global_rotation = arme_instance.global_rotation
		shoutedbullet.global_position=shoutingArme.get_node("bulletSpawn").global_position
		get_tree().current_scene.add_child(shoutedbullet)
		Armequiped.chargeur-=1
	else:
		print("chargeur vide")
	

	
