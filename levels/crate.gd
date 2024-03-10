extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var player: CharacterBody2D = get_parent().player

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	move_and_slide()
	
	if $LeftPush.is_colliding():
		var collider = $LeftPush.get_collider()
		if collider.velocity.x > 0:
			if collider.velocity.x > 360 or collider.velocity.x < 10:
				collider.velocity.x = 360
			velocity.x = collider.velocity.x
	
	if $RightPush.is_colliding():
		var collider = $RightPush.get_collider()
		if collider.velocity.x < 0:
			if collider.velocity.x < -360 or collider.velocity.x > -10:
				collider.velocity.x = -360
			velocity.x = collider.velocity.x
	
	#var player = is_hitting_player()
	#
	#if player:
		#velocity.x = player.velocity.x
		#move_and_slide()

func is_hitting_player():
	for i in range(get_slide_collision_count()):
		var collider = get_slide_collision(i).get_collider()
		if collider is CharacterBody2D:
			return collider
	return null
