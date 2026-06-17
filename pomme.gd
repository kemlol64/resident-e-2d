extends Area2D
@export var data: Objet




func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		print("object detected")
		body.CanInteract()

		
	
	
