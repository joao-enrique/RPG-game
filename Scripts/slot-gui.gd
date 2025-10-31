class_name SlotGui extends Button

signal hovering_started
signal hovering_ended

@onready var backgroundSprite: Sprite2D = $background
@onready var container: CenterContainer = $CenterContainer
@onready var inventory = preload("res://inventoryItems/playerInventory.tres")

var itemStackGui: ItemStackGui
var index: int

func insert(isg: ItemStackGui):
	itemStackGui = isg
	backgroundSprite.frame = 1 
	container.add_child(itemStackGui)
	
	if !itemStackGui.inventorySlot || inventory.slots[index] == itemStackGui.inventorySlot: return
	
	inventory.insertSlot(index, itemStackGui.inventorySlot)

func takeItem():
	var item = itemStackGui
	
	inventory.removeSlot(itemStackGui.inventorySlot)
	
	return item
	
func isEmpty():
	return !itemStackGui
	
func clear() -> void:
	if itemStackGui:
		container.remove_child(itemStackGui)
		itemStackGui = null
	backgroundSprite.frame = 0


func _on_mouse_entered():
	hovering_started.emit(self)


func _on_mouse_exited():
	hovering_ended.emit(self)
	print_debug("Saiu")
