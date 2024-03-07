extends CanvasLayer

@onready var main_node = get_parent()
@onready var can_exit = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input(event: InputEvent):
	if not event is InputEventKey:
		return
	if event.is_action_pressed("exit"):
		var instance = main_node.main_menu.instantiate()
		
		main_node.add_child(instance)
		self.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(_delta: float):
	pass

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
