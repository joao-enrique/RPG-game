extends BaseScene

@onready var heartsContainer = $CanvasLayer/heartsContainer
@onready var camera = $follow_cam

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer.visible = true
	super()
	camera.follow_node = player
	
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(heartsContainer.updateHearts)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_inventory_gui_closed():
	get_tree().paused = false


func _on_inventory_gui_opened():
	get_tree().paused = true
