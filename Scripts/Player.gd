class_name Player
extends CharacterBody2D

@export var speed := 100.0

@onready var animation: PlayerAnimation = $PlayerAnimation

var states: Dictionary = {}
var current_state: PlayerState


func _ready():
	states = {
		"idle": PlayerIdle.new(),
		"move": PlayerMove.new(),
		"locked": PlayerLocked.new()
	}

	for state in states.values():
		state.player = self
		add_child(state)

	change_state("idle")


func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)


func change_state(state_name: String):
	if current_state:
		current_state.exit()

	current_state = states[state_name]
	current_state.enter()


func get_input_direction() -> Vector2:
	if Input.is_action_pressed("ui_right"):
		return Vector2.RIGHT
	elif Input.is_action_pressed("ui_left"):
		return Vector2.LEFT
	elif Input.is_action_pressed("ui_down"):
		return Vector2.DOWN
	elif Input.is_action_pressed("ui_up"):
		return Vector2.UP

	return Vector2.ZERO
