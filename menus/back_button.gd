extends TextureButton

@export var exit_to: String

@onready var main_node = $/root/Main

func _ready():
	pass
	#while main_node.name != "Main":
	#	main_node = main_node.get_parent()
	
	#main_node = $/root/Main.get_child(0).get_parent()

func _on_pressed():
	var instance = main_node[exit_to].instantiate()
	var scene = main_node.get_child(0)
	
	main_node.add_child(instance)
	scene.queue_free()
