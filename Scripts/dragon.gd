extends CharacterBody2D

@export var speed = 20 
@export var limit = 0.5 

@onready var animations = $AnimationPlayer

var startPosition
var endPosition
var isDead: bool = false

func _ready():
	startPosition = position
	
func updateAnimation():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
		
		animations.play("Walk"+direction)
		
func _physics_process(delta):
	if isDead: return
	move_and_slide()
	updateAnimation()


func _on_hurt_box_area_entered(area):
	if area == $hitBox: return
	$hitBox.set_deferred("monitorable", false)
	isDead = true
	animations.play("death")
	await animations.animation_finished
	queue_free()
