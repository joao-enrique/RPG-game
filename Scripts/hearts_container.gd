extends HBoxContainer

@onready var HeartsGuiClass = preload("res://GUI/heartGui.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setMaxHearts(max: int):
	max = max /4
	for i in range(max):
		var heart = HeartsGuiClass.instantiate()
		add_child(heart)

func updateHearts(currentHealth: int):
	var hearts = get_children()
	
	var full_hearts = currentHealth / 4
	
	for i in range(full_hearts):
		hearts[i].update(4)
		
	if full_hearts == hearts.size(): return
	
	var remaider = currentHealth % 4
	hearts[full_hearts].update(remaider)
		
	for i in range(full_hearts + 1, hearts.size()):
		hearts[i].update(0)
