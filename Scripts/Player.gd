class_name Player
extends CharacterBody2D

@export var speed := 100.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var states = {}
var current_state: PlayerState
var last_direction := Vector2.DOWN


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
	current_state.physics_update(delta)


func change_state(state_name: String):
	if current_state:
		current_state.exit()

	current_state = states[state_name]
	current_state.enter()

func update_animation(direction: Vector2):
	var anim := ""

	if direction != Vector2.ZERO:
		last_direction = direction
		match direction:
			Vector2.RIGHT:
				anim = "walk_right"
			Vector2.LEFT:
				anim = "walk_left"
			Vector2.DOWN:
				anim = "walk_down"
			Vector2.UP:
				anim = "walk_up"
	else:
		match last_direction:
			Vector2.RIGHT:
				anim = "idle_right"
			Vector2.LEFT:
				anim = "idle_left"
			Vector2.DOWN:
				anim = "idle_down"
			Vector2.UP:
				anim = "idle_up"

	if animation_player.current_animation != anim:
		animation_player.play(anim)


func play_idle_animation():
	var anim := ""

	match last_direction:
		Vector2.RIGHT:
			anim = "idle_right"
		Vector2.LEFT:
			anim = "idle_left"
		Vector2.DOWN:
			anim = "idle_down"
		Vector2.UP:
			anim = "idle_up"

	if animation_player.current_animation != anim:
		animation_player.play(anim)

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
