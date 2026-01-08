class_name Enemy
extends Node2D

@export var dialogue_scene: PackedScene
var dialogue_shown := false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if dialogue_shown:
		return
	
	var bubble = dialogue_scene.instantiate()
	get_tree().current_scene.add_child(bubble)
	bubble.show_message("Ei! Que tal batalhar com meus FakeMons?!",5.0)
	dialogue_shown = true
	print("Vamos batalhar!!", body.name)

	
