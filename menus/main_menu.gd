extends CanvasLayer

var level_select = preload("res://menus/level_select.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	pass


func _on_play_button_pressed():
	var instance = level_select.instantiate()
	get_parent().add_child(instance)
	
	self.queue_free()
