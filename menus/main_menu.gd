extends CanvasLayer

var level_select = preload("res://menus/level_select.tscn")
var how_to_play = preload("res://menus/how_to_play.tscn")


func _on_play_button_pressed():
	var instance = level_select.instantiate()
	get_parent().add_child(instance)
	
	self.queue_free()


func _on_how_to_play_button_pressed():
	var instance = how_to_play.instantiate()
	get_parent().add_child(instance)
	
	self.queue_free()


func _on_quit_button_pressed():
	get_tree().quit()
