extends Area2D
@export var ArmeData: Arme
var player_in = null

#variable qui va dire si le joueur est dans ou en dehors de la zone 
#elle va prendre la valeur de l'objet dans la zone ou null si y'a personne
# comme ca ont sait sile joueur est dans la zone et peut interagir avec les objet en question ou pas

func _on_body_entered(body: CharacterBody2D) -> void:
	player_in = body
	player_in.CanInteract("[E] [F]")
	print("Arme detected")
		

	
func _process(delta: float) -> void:
	if player_in !=null and Input.is_action_just_pressed("interact"):
		player_in.ramasser(null,ArmeData)
		queue_free()
	if player_in !=null and Input.is_action_just_pressed("Equiper"):
		player_in.ramasser(null,ArmeData)
		player_in.Equiper(ArmeData)
		queue_free()
	

func _on_body_exited(body: Node2D) -> void:
	player_in=null
	if body.is_in_group("Player"):
		body.CantInteract()
