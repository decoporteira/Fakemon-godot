class_name PlayerIdle
extends PlayerState

func enter():
	player.animation.play_idle()

func physics_update(_delta):
	var dir = player.get_input_direction()
	if dir != Vector2.ZERO:
		player.change_state("move")
