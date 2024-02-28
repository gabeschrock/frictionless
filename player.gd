extends RigidBody2D

var yPos = position.y

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("jump") and position.y == yPos:
		linear_velocity.y = -800
	yPos = position.y
	
	if Input.is_action_pressed("move_right"):
		linear_velocity.x += 400 * delta
	if Input.is_action_pressed("move_left"):
		linear_velocity.x -= 400 * delta
	
	#var tile_index = danger_tilemap.local_to_map(position)
	#if danger_tilemap.get_cell_tile_data(0, tile_index):
		#print("hit danger")


func _on_danger_hitbox_body_entered(_body):
	print("hit")
