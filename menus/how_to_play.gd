extends CanvasLayer

@onready var main_node = get_parent()

func _ready():
	# var image = Image.load_from_file("res://assets/arrow-button/normal.png")
	
	var click_mask = BitMap.new()
	#click_mask.create_from_image_alpha(image)
	click_mask.create(Vector2(9, 16))
	click_mask.set_bit_rect(Rect2i(0, 0, 9, 16), true)
	
	$RightButton.set_click_mask(click_mask)

func _input(event: InputEvent):
	if not event is InputEventKey:
		return
	if event.is_action_pressed("exit"):
		var instance = main_node.main_menu.instantiate()
		
		main_node.add_child(instance)
		self.queue_free()

func _on_left_button_pressed():
	print("left button pressed")

func _on_right_button_pressed():
	print("right button pressed")
