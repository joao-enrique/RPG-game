class_name InfoPanel extends Control

@onready var label: Label = $Label

func display(item: InventoryItems) -> void:
	label.text = item.name
	visible = true
