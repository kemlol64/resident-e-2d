extends Sprite2D

@export var balleData= Objet
@export var speed :float = 10000

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += Vector2.RIGHT.rotated(global_rotation) * speed * delta
