extends CanvasLayer

@onready var main_node = get_parent()

func open_level(level: int):
	main_node.load_level(level)
	self.queue_free()

func _on_level_1_pressed():
	open_level(1)
