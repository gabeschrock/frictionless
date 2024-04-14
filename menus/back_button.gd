extends TextureButton

@export var exit_to: String

@onready var main_node = get_tree().root

func _ready():
	print(self.filename)

func _on_pressed():
	var instance = main_node[exit_to].instantiate()
	
	main_node.add_child(instance)
	owner.queue_free()
