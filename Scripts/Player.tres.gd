class_name Player extends CharacterBody2D

@export var speed := 100.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

var player_can_move = true
var last_direction := Vector2.DOWN


func _physics_process(_delta):
	if player_can_move == false:
		velocity = Vector2.ZERO
		play_idle_animation()
		move_and_slide()
		return
		
	var direction := Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		direction = Vector2.RIGHT
	elif Input.is_action_pressed("ui_left"):
		direction = Vector2.LEFT
	elif Input.is_action_pressed("ui_down"):
		direction = Vector2.DOWN
	elif Input.is_action_pressed("ui_up"):
		direction = Vector2.UP

	velocity = direction * speed
	move_and_slide()
	update_animation(direction)


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
