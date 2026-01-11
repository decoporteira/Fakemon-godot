class_name PlayerMove
extends PlayerState

func physics_update(_delta):
	var dir = player.get_input_direction()

	player.velocity = dir * player.speed
	player.move_and_slide()

	player.animation.play_walk(dir)

	if dir == Vector2.ZERO:
		player.change_state("idle")
