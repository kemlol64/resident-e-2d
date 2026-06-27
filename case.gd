extends Panel
@onready var itemTexture=$TextureRect
@onready var ItemQuantity=$Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Cette fonction permet de remplir une case par un objet elle prend l'objet a mettre
#dans la case si la case doit etre vide elle reste vide sinon ont y met l'icon de l'objet
#ainsi que sa quantite dans label
func set_item(item:Objet,index:int): #item objet a mettre dans la case , index c'est l'indes de la case (a voir utilite dans le script inventaire)
	var case_index=index
	if(item==null):#Si la case ne contient pas encore d'ojet
		itemTexture.texture=null
		ItemQuantity.text=""
	else :#Si la case contient un objet de l'inventaire
		itemTexture.texture=item.icon
		ItemQuantity.text=str(item.quantite)
	
