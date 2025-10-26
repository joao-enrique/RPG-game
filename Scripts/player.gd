extends CharacterBody2D

signal healthChanged

@export var speed: int = 35
@onready var animations = $animations
@onready var effects = $effects
@onready var collision = $CollisionShape2D
@onready var hurtTimer = $hurtTimer
@onready var currentHealth: int = maxHealth
@onready var hurtBox = $hurtBox

@export var maxHealth = 3
@export var knockbackPower: int = 500

var isHurt: bool = false

func _ready():
	effects.play("RESET")

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed
	
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
	handleInput()
	move_and_slide()
	updateAnimation()
	if !isHurt:
		for area in hurtBox.get_overlapping_areas():
			if area.name == "hitbox":
				hurtByEnemy(area)

func hurtByEnemy(area):
	currentHealth -= 1
	if currentHealth < 0:
		currentHealth = maxHealth
	healthChanged.emit(currentHealth)
	isHurt = true
		
	knoback(area.get_parent().velocity)
	effects.play("hurtBlink")
	hurtTimer.start()
	await hurtTimer.timeout
	effects.play("RESET")
	isHurt = false
	
func knoback(enemyVelocity: Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	print_debug(velocity)
	print_debug(position)
	move_and_slide()
	print_debug(position)
	print_debug(" ")

func _on_hurt_box_area_entered(area):
	if area.has_method("collect"):
		area.collect()
		

func _on_hurt_box_area_exited(area): pass
