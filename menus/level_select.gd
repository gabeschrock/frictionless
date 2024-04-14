extends CanvasLayer

@onready var main_node = get_parent()

func open_level(level: int):
	main_node.load_level(level)
	self.queue_free()

func _on_level_1_pressed():
	open_level(1)

func _on_level_2_pressed():
	open_level(2)

func _on_level_3_pressed():
	open_level(3)

func _on_level_4_pressed():
	open_level(4)

func _on_level_5_pressed():
	open_level(5)
