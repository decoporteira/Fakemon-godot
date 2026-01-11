class_name PlayerLocked
extends PlayerState

func enter():
	player.velocity = Vector2.ZERO
	player.play_idle_animation()

func physics_update(_delta):
	player.velocity = Vector2.ZERO
	player.move_and_slide()
