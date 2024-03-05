extends CharacterBody2D

@export var tilemap: TileMap
@export var current_level: int

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var main_node = get_parent().get_parent()

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var door_atlas_coords = Vector2i(0, 2)

func _physics_process(delta: float):
	# Check if exiting to level select, placed first to remove unnessecary processing
	if Input.is_action_just_pressed("exit"):
		var instance = main_node.level_select.instantiate()
		main_node.add_child(instance)
		get_parent().queue_free()
	
	# Check if touching door tile
	var tilePos = tilemap.local_to_map(position)
	var coords = tilemap.get_cell_atlas_coords(0, tilePos / 4)
	
	if coords == door_atlas_coords:
		current_level += 1
		get_parent().get_parent().load_level(current_level)
		get_parent().queue_free()
	
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get input direction and handle the acceleration.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x += direction * SPEED * delta
	else:
		velocity.x += move_toward(velocity.x, 0, SPEED) * delta
	
	if velocity.x:
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.scale.x = sign(velocity.x) * 4
	else:
		$AnimatedSprite2D.play("idle")
	
	move_and_slide()


func _on_danger_hitbox_body_entered(body: Node2D):
	if body != self:
		return
	main_node.load_level(current_level)
	get_parent().queue_free()
