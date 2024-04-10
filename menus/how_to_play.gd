extends CanvasLayer

var normal = preload("res://assets/arrow-button/normal.png")

func _ready():
	var click_mask = BitMap.new()
	click_mask.create(Vector2(9, 16))
	click_mask.set_bit_rect(Rect2i(0, 0, 9, 16), true)
	
	$RightButton.texture_click_mask = click_mask
