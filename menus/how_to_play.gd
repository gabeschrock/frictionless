extends CanvasLayer

var PAGE_COUNT = 3

var page = 0

func _on_left_button_pressed():
	self.get_node("Page" + str(page)).visible = false
	
	page += PAGE_COUNT - 1
	page %= PAGE_COUNT
	
	self.get_node("Page" + str(page)).visible = true

func _on_right_button_pressed():
	self.get_node("Page" + str(page)).visible = false
	
	page += PAGE_COUNT + 1
	page %= PAGE_COUNT
	
	self.get_node("Page" + str(page)).visible = true
