extends CanvasLayer

@onready var label := $Panel/Label

func show_message(text: String, duration := 2.0):
	label.text = text
	visible = true
	
	await get_tree().create_timer(duration).timeout
	queue_free()
