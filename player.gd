extends CharacterBody2D

@export var tilemap: TileMap

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var current_level = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var door_atlas_coords = Vector2i(0, 2)

func _physics_process(delta: float):
	var tilePos = tilemap.local_to_map(position)
	var coords = tilemap.get_cell_atlas_coords(0, tilePos)
	
	if coords == door_atlas_coords:
		current_level += 1
		get_parent().get_parent().load_level(current_level)
		get_parent().queue_free()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x += direction * SPEED * delta
	else:
		velocity.x += move_toward(velocity.x, 0, SPEED) * delta

	move_and_slide()


func _on_danger_hitbox_body_entered(body: Node2D):
	if body != self:
		return
	get_parent().get_parent().load_level(current_level)
	get_parent().queue_free()
