@tool
extends Area2D
@export var data: Objet:
	set(value):
		data = value
		var sprite = get_node_or_null("CollisionShape2D/Sprite2D")
		if sprite != null:
			sprite.texture = data.icon if data else null
@onready var sprite2D=$CollisionShape2D/Sprite2D
var player_in = null
#variable qui va dire si le joueur est dans ou en dehors de la zone 
#elle va prendre la valeur de l'objet dans la zone ou null si y'a personne
# comme ca ont sait sile joueur est dans la zone et peut interagir avec les objet en question ou pas
func _ready() -> void:
	if data != null:
		sprite2D.texture=data.icon
func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		player_in=body
		print("object detected")
		player_in.CanInteract()
		
func _on_body_exited(body: Node2D) -> void:	
	player_in=null
	if body.is_in_group("Player"):
		body.CantInteract()

func _process(delta: float) -> void:
	if player_in !=null and Input.is_action_just_pressed("interact"):
		player_in.ramasser(data)
		queue_free()
		
