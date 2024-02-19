extends RigidBody2D

var yPos = position.y

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#if Input.is_action_just_pressed("jump"):
		#linear_velocity.y -= 800
	#if Input.is_action_pressed("move_right"):
		#linear_velocity.x += 400 * delta
	#if Input.is_action_pressed("move_left"):
		#linear_velocity.x -= 400 * delta

func _physics_process(delta):
	if Input.is_action_just_pressed("jump") and position.y == yPos:
		linear_velocity.y = -800
	yPos = position.y
	
	if Input.is_action_pressed("move_right"):
		linear_velocity.x += 400 * delta
	if Input.is_action_pressed("move_left"):
		linear_velocity.x -= 400 * delta
	
