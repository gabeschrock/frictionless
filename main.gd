extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Load a level and add it as a child. 'level' is an integer 1 or more.
func load_level(level):
	var level_scene = load("res://levels/level_" + str(level) + ".tscn")
	var instance = level_scene.instantiate();
	
	call_deferred("add_child", instance);
