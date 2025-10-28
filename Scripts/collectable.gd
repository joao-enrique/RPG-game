extends Area2D

@export var itemRes: InventoryItems

func collect(inventory: Inventory):
	inventory.insert(itemRes)
	print_debug(itemRes)
	queue_free()
