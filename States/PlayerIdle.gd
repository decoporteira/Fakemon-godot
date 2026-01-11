class_name PlayerIdle
extends PlayerState

func enter():
	player.velocity = Vector2.ZERO
	player.play_idle_animation()

func physics_update(_delta):
	var direction = player.get_input_direction()

	if direction != Vector2.ZERO:
		player.change_state("move")
