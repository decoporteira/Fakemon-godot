class_name MovingEnemy
extends CharacterBody2D

@export var speed := 30.0
@export var change_dir_time := 1
@onready var animation_enemy: AnimationPlayer = $AnimationPlayer

var direction := Vector2.ZERO
var dialogue_shown := false
var player: Player

@onready var timer: Timer = $Timer

func _ready():
	player = get_tree().current_scene.get_node("Player")
	_pick_random_direction()

	timer.wait_time = change_dir_time
	timer.one_shot = false
	timer.start()

func _physics_process(_delta):
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
		Vector2.ZERO # opcional: pausa
	]
	direction = dirs.pick_random()

func _on_timer_timeout():
	_pick_random_direction()
