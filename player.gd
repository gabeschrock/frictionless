extends CharacterBody2D

@export var tilemap: TileMap
@export var current_level: int

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var main_node = get_parent().get_parent()

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var door_atlas_coords = Vector2i(0, 2)
var zone_all_atlas_coords = Vector2i(-1, -1)
var zone_up_atlas_coords = Vector2i(0, 5)

func _physics_process(delta: float):
	# Get tilemap coordinates
	var tilePos = tilemap.local_to_map(position) / 4
	
	var blocks_coords = tilemap.get_cell_atlas_coords(0, tilePos)
	var zone_coords = tilemap.get_cell_atlas_coords(3, tilePos)
	
	var move_side = true
	var move_up = true
	
	# Check zone
	if zone_coords == zone_up_atlas_coords:
		move_side = false
	elif zone_coords != zone_all_atlas_coords:
		printerr("Unexpected zone at:\nLevel " + str(current_level) + "\nPosition " + str(tilePos)
		 + "\nAtlas Coordinates " + str(zone_coords))
	
	# Check if touching door
	if blocks_coords == door_atlas_coords:
		current_level += 1
		load_level()
	
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump
	if move_up and Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get input direction and handle the acceleration.
	var direction
	
	if move_side:
		direction = Input.get_axis("move_left", "move_right")
	else:
		direction = 0
	
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

func _input(event: InputEvent):
	# Only handling keyboard events
	if not event is InputEventKey:
		return
	
	# Check to restart level
	if event.is_action_pressed("restart"):
		load_level()
	
	# Check to exit to level select
	if event.is_action_pressed("exit"):
		var instance = main_node.level_select.instantiate()
		
		main_node.add_child(instance)
		get_parent().queue_free()

func _on_danger_hitbox_body_entered(body: Node2D):
	if body != self:
		return
	load_level()

func load_level():
	main_node.load_level(current_level)
	get_parent().queue_free()

