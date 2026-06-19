extends CharacterBody2D
@onready var player=$"."
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
	var direction = Vector2.ZERO

	if Input.is_action_pressed("left_walk"):
		direction.x = -1
	if Input.is_action_pressed("right_walk"):
		direction.x = 1
	if Input.is_action_pressed("up_walk"):
		direction.y = -1
	if Input.is_action_pressed("down_walk"):
		direction.y = 1

	if direction.x != 0 or direction.y != 0:
		direction = direction.normalized()
	velocity = speed * direction
	move_and_slide()

	if Input.is_action_pressed("Attack"):
		Attack()
	if Input.is_action_pressed("Shout"):
		shoot()

func _process(delta: float) -> void:
	if Armequiped == null:
		return

	var mouse_pos = get_global_mouse_position()
	var dir_to_mouse = mouse_pos - global_position

	# Le sprite se retourne selon la position de la souris par rapport au perso
	if dir_to_mouse.x < 0:
		sprite2D.scale.x = -1
		if arme_instance != null:
			arme_instance.scale.y = -1
	else:
		sprite2D.scale.x = 1
		if arme_instance != null:
			arme_instance.scale.y = 1

	# L'angle brut vers la souris
	var angle = dir_to_mouse.angle()

	# On clamp entre -60 et 60 degrés dans le référentiel local du perso
	var angle_local = angle
	if sprite2D.scale.x < 0:
		angle_local = PI - angle
		angle_local = wrapf(angle_local, -PI, PI)

	var angle_deg = rad_to_deg(angle_local)
	angle_deg = clamp(angle_deg, -60.0, 60.0)
	var angle_clamped = deg_to_rad(angle_deg)

	# On réapplique dans le bon sens
	if sprite2D.scale.x < 0:
		GunSpawn.rotation = PI - angle_clamped
	else:
		GunSpawn.rotation = angle_clamped

# VERIFYING AREA FUNCTION /////////////////////////////
func VerifyArea(area: Area2D):
	var intrus = area.get_parent()
	if intrus.is_in_group("enemy"):
		print("Enemy en vue")

# ATTACKING FUNCTION //////////////////////////////
func Attack(enemy: Node2D = null):
	if enemy != null:
		enemy.health -= damage

# RAMASSER FUNCTION //////////////////////
func ramasser(Objetdata: Objet = null, Armedata: Arme = null):
	print("item picked up go check it !!")

func CanInteract(InteractText: String = "[E]"):
	interactlabel.set_text(InteractText)
	interactlabel.show()

func CantInteract():
	interactlabel.hide()

var arme_instance: Node2D = null
var shoot_timer: float = 0.0

func Equiper(ArmeData: Arme):
	Armequiped = ArmeData
	for fils in GunSpawn.get_children():
		fils.queue_free()
	var newArme = armes.instantiate()
	newArme.ArmeData = Armequiped
	newArme.global_position = GunSpawn.global_position
	GunSpawn.add_child(newArme)
	arme_instance = newArme

func shoot():
	if Armequiped == null:
		return
	if Armequiped.chargeur <= 0:
		print("chargeur vide")
		return

	var shoutedbullet = balle.instantiate()
	get_tree().current_scene.add_child(shoutedbullet)
	shoutedbullet.global_position = arme_instance.get_node("bulletSpawn").global_position
	shoutedbullet.global_rotation = GunSpawn.global_rotation

	Armequiped.chargeur -= 1

func changer_direction(noeud: Node2D) -> void:
	noeud.scale.x *= -1
