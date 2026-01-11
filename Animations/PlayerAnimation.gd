class_name PlayerAnimation
extends Node

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

var last_direction := Vector2.DOWN


func play_walk(direction: Vector2):
	if direction == Vector2.ZERO:
		return

	last_direction = direction

	match direction:
		Vector2.RIGHT: animation_player.play("walk_right")
		Vector2.LEFT:  animation_player.play("walk_left")
		Vector2.DOWN:  animation_player.play("walk_down")
		Vector2.UP:    animation_player.play("walk_up")


func play_idle():
	match last_direction:
		Vector2.RIGHT: animation_player.play("idle_right")
		Vector2.LEFT:  animation_player.play("idle_left")
		Vector2.DOWN:  animation_player.play("idle_down")
		Vector2.UP:    animation_player.play("idle_up")
