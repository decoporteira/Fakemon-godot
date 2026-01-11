class_name PlayerMove
extends PlayerState

func physics_update(_delta):
	var direction = player.get_input_direction()

	if direction == Vector2.ZERO:
		player.change_state("idle")
		return

	player.velocity = direction * player.speed
	player.move_and_slide()
	player.update_animation(direction)
