extends Control
var case = preload("res://Case.tscn")
@onready var grid= $Panel/GridContainer
var MAX_INVENTORY_CASES=10
var player=preload("res://playerfrog.tscn")
var slots=[]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialise_inventory()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func initialise_inventory():
	for i in range(MAX_INVENTORY_CASES):
		var slot=case.instantiate()
		grid.add_child(slot)
		slots.append(slot)
	hide()

func refresh_inventory(inventory: Array):
	for i in range(slots.size()):
		if i <inventory.size() :
			slots[i].set_item(inventory[i],i)
		else : slots[i].set_item(null,i)
		
	
		
	
