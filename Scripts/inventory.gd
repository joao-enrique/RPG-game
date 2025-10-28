extends Resource

class_name Inventory

signal updated

@export var items: Array[InventoryItems]

func insert(item: InventoryItems):
	for i in range(items.size()):
		if !items[i]:
			items[i] = item
			break
			
	updated.emit()
