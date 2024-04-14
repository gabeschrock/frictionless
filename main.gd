extends Node

@export var main_menu = preload("res://menus/main_menu.tscn")
@export var level_select = preload("res://menus/level_select.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var instance = main_menu.instantiate()
	add_child(instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	pass

# Load a level and add it as a child. 'level' is an integer 1 or more.
func load_level(level: int):
	var level_scene = load("res://levels/level_" + str(level) + ".tscn")
	var instance = level_scene.instantiate();
	
	add_child(instance)
