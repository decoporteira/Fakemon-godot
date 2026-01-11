class_name Enemy
extends Node2D

@export var dialogue_scene: PackedScene

var dialogue_shown := false
var player_node2d: Player


func _ready():
	player_node2d = get_tree().current_scene.get_node("Player")
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if dialogue_shown:
		return

	if body is Player:
		player_node2d.change_state("locked")
	
	var bubble = dialogue_scene.instantiate()
	get_tree().current_scene.add_child(bubble)
	bubble.show_message("Ei! Que tal batalhar com meus FakeMons?!", 3.0)
	
	dialogue_shown = true
	
	await get_tree().create_timer(4.0).timeout
	
	get_tree().change_scene_to_file("res://Battle/Battle.tscn")
