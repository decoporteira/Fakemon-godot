class_name Enemy
extends Node2D

@export var dialogue_scene: PackedScene
var dialogue_shown := false
var player_node2d

func _ready():
	player_node2d = get_tree().current_scene.get_node("Player")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if dialogue_shown:
		return

	if body.name == "Player":
		player_node2d.player_can_move = false
	
	var bubble = dialogue_scene.instantiate()
	get_tree().current_scene.add_child(bubble)
	bubble.show_message("Ei! Que tal batalhar com meus FakeMons?!", 3.0)
	
	dialogue_shown = true
	
	await get_tree().create_timer(4po.0).timeout
	
	print("Vamos batalhar!!", body.name)
	
	get_tree().change_scene_to_file("res://Battle/Battle.tscn")
