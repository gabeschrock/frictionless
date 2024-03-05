extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Level4.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func open_level(level: int):
	get_parent().load_level(level)
	self.queue_free()

func _on_level_1_pressed():
	open_level(1)


func _on_level_2_pressed():
	open_level(2)


func _on_level_3_pressed():
	open_level(3)


func _on_level_4_pressed():
	open_level(4)
