class_name FollowMovement
extends Node

@export var speed: float = 20
@onready var parent: CharacterBody2D = get_parent()
@onready var follow_area = $"../FollowArea"
@onready var visibility_tracker = $"../VisibleOnScreenNotifier2D"
@export var follow_duration: int = 2
@export var folllow_distance: int = 160
@export var overshoot_limit: int = 2

var start_position: Vector2
var start_visibility = VisibleOnScreenNotifier2D.new()
var target: Player
var is_dead: bool = false

enum State{IDLE, FOLLOW, BACK}
var current_state: State = State.IDLE

func _ready() -> void:
	start_position = parent.position
	add_child(start_visibility)
	start_visibility.global_position = start_position

func update_velocity() -> void:
	match current_state:
		State.IDLE:
			parent.velocity = Vector2.ZERO
			var overlapping = follow_area.get_overlapping_bodies()
			var filtered = overlapping.filter(func (b): return b is Player)
			if !filtered.is_empty():
				follow_body(filtered[0])
		State.FOLLOW:
			var dist_to_start = (start_position - parent.global_position).length()
			if dist_to_start > folllow_distance:
				target = null
				current_state = State.BACK
				return
	
			var direction = target.global_position - parent.global_position
			var new_velocity = direction.normalized() * speed
			parent.velocity = new_velocity
	
		State.BACK:
				var dir_to_start = start_position - parent.global_position
				if dir_to_start.length() < overshoot_limit || out_of_sight():
					parent.global_position = start_position
					current_state = State.IDLE
					return
				parent.velocity = dir_to_start.normalized() * speed

func out_of_sight() -> bool:
	return !visibility_tracker.is_on_screen() && !start_visibility.is_on_screen()

func follow_body(body) -> void:
	target = body
	current_state = State.FOLLOW
	await get_tree().create_timer(follow_duration).timeout
	stop_follow()
	
func stop_follow() -> void:
	if current_state == State.FOLLOW:
		target = null
		current_state = State.BACK

func _physics_process(delta: float) -> void:
	update_velocity()
	parent.move_and_slide()

func disable() -> void:
	is_dead = true
	process_mode = ProcessMode.PROCESS_MODE_DISABLED




#func _on_follow_area_body_exited(body):
	#if body == target:
		#target = null



func _on_visible_on_screen_notifier_2d_screen_exited():
	if current_state == State.FOLLOW:
		current_state = State.BACK
