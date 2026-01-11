class_name MovingEnemy
extends CharacterBody2D

@export var speed := 30.0
@export var change_dir_time := 1
@onready var animation_enemy: AnimationPlayer = $AnimationPlayer
@export var dialogue_scene: PackedScene
var player_node2d: Player
var direction := Vector2.ZERO
var dialogue_shown := false
var player: Player
var last_direction := Vector2.DOWN
var stop_moving = false
@onready var timer: Timer = $Timer

func _ready():
	player = get_tree().current_scene.get_node("Player")
	_pick_random_direction()

	timer.wait_time = change_dir_time
	timer.one_shot = false
	timer.start()

func _physics_process(_delta):
	if stop_moving == true:
		animation_enemy.stop()
		return
		
	velocity = direction * speed

	match direction:
		Vector2.RIGHT: animation_enemy.play("walk_right")
		Vector2.LEFT: animation_enemy.play("walk_left")
		Vector2.UP: animation_enemy.play("walk_up")
		Vector2.DOWN: animation_enemy.play("walk_down")
		
	move_and_slide() 

func _pick_random_direction():
	var dirs = [
		Vector2.RIGHT,
		Vector2.LEFT,
		Vector2.UP,
		Vector2.DOWN,
	]
	direction = dirs.pick_random()


func _on_timer_timeout():
	_pick_random_direction()


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.name )
	if body.name == 'Player':
		player.change_state("locked")
		direction = Vector2.ZERO
		stop_moving = true
		
	var bubble = dialogue_scene.instantiate()
	get_tree().current_scene.add_child(bubble)
	bubble.show_message("Ei! Que tal batalhar com meus FakeMons?!", 3.0)
	
	dialogue_shown = true
	
	await get_tree().create_timer(4.0).timeout
	
	get_tree().change_scene_to_file("res://Battle/Battle.tscn")
