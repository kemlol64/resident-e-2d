extends Node2D
@export var ArmeData: Arme
@onready var sprite2D=$Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite2D.texture=ArmeData.icon


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
