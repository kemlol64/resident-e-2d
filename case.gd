extends Panel
@onready var itemTexture=$TextureRect
@onready var ItemQuantity=$Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func set_item(item:Objet,index:int):
	var case_index=index
	if(item==null):
		itemTexture.texture=null
		ItemQuantity.text=""
	else :
		itemTexture.texture=item.icon
		ItemQuantity.text=str(item.quantite)
	
