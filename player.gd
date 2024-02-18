extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_pressed("move_right"):
		linear_velocity.x += 400 * delta
	if Input.is_action_pressed("move_left"):
		linear_velocity.x -= 400 * delta
	if Input.is_action_pressed("jump"):
		linear_velocity.y -= 400
