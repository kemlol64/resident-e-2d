extends Control
var case = preload("res://Case.tscn")
@onready var gridObjet=$BigContainer/HBoxContainer/InventaireObjet/GridObjetSlot
@onready var gridArme=$BigContainer/HBoxContainer/InventaireArme/GridArmeSlot
var MAX_INVENTORY_CASES=10
var player=preload("res://playerfrog.tscn")
var slots=[]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialise_inventory()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
#Cette fonction sert a creer les slots dans l'inventaire
func initialise_inventory():
	var i=0
	while i<MAX_INVENTORY_CASES:
		if i<9:
			var slot=case.instantiate()
			gridObjet.add_child(slot)
			slots.append(slot)
			i+=1
		else:
			var slot=case.instantiate()
			gridArme.add_child(slot)
			slots.append(slot)
			i+=1
	hide()

func refresh_inventory(inventoryObjet: Array,inventoryArme: Array):
	print("slots : ", slots.size(), " objets : ", inventoryObjet.size())
	for i in range(slots.size()):
		if i <inventoryObjet.size() :
			slots[i].set_item(inventoryObjet[i],i)
		else : slots[i].set_item(null,i)
	var j=0
	for i in range(slots.size()):
		if i <inventoryArme.size() :
			slots[j].set_item(inventoryArme[i],i)
			j+=1
		else : 
			slots[j].set_item(null,i)
			j+=1
			
		
	
		
	
