extends CharacterBody2D

@export var tilemap: TileMap
@export var current_level: int
@export var button_script_holder: Node

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var main_node = get_parent().get_parent()
@onready var crate: CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var door_atlas_coords = Vector2i(0, 2)
var zone_all_atlas_coords = Vector2i(-1, -1)
var zone_up_atlas_coords = Vector2i(0, 5)

var button_atlas_coords = Vector2i(1, 1)
var button_pressed_atlas_coords = Vector2i(2, 1)

var button_pressed_coords = null

func _physics_process(delta: float):
	# Get tilemap coordinates
	var tile_pos = tilemap.local_to_map(position) / 4
	
	var blocks_coords = tilemap.get_cell_atlas_coords(0, tile_pos)
	var zone_coords = tilemap.get_cell_atlas_coords(3, tile_pos)
	
	if button_pressed_coords and tile_pos != button_pressed_coords:
		var tile_data = tilemap.get_cell_tile_data(0, button_pressed_coords)
		var alt_tile = tiledata_to_alt_tile(tile_data)
		tilemap.set_cell(0, button_pressed_coords, 1, button_atlas_coords, alt_tile)
	if blocks_coords == button_atlas_coords:
		button_pressed_coords = tile_pos
		var tile_data = tilemap.get_cell_tile_data(0, tile_pos)
		var alt_tile = tiledata_to_alt_tile(tile_data)
		
		button_script_holder.button_pressed(tile_pos)
		
		tilemap.set_cell(0, tile_pos, 1, button_pressed_atlas_coords, alt_tile)
	
	
	var move_side = true
	var move_up = true
	
	# Check zone
	if zone_coords == zone_up_atlas_coords:
		move_side = false
	elif zone_coords != zone_all_atlas_coords:
		printerr("Unexpected zone at:\nLevel " + str(current_level) + "\nPosition " + str(tile_pos)
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

	var direction
	
	# Get input direction and handle the acceleration.
	if move_side:
		direction = Input.get_axis("move_left", "move_right")
	else:
		direction = 0
	
	if direction:
		velocity.x += direction * SPEED * delta
		if crate:
			crate.velocity.x = velocity.x
			crate.move_and_slide()
			if crate.velocity.x != velocity.x:
				velocity.x = 0
		#if -10 <= velocity.x and velocity.x <= 10:
			#velocity.x = 11 * sign(direction)
	else:
		velocity.x += move_toward(velocity.x, 0, SPEED) * delta
	
	$WalkParticles.emitting = is_on_floor() and abs(velocity.x) > 30
	
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

func tiledata_to_alt_tile(button_tile_data: TileData):
	var flip_h    = button_tile_data.flip_h
	var flip_v    = button_tile_data.flip_v
	var transpose = button_tile_data.transpose
	if flip_h != flip_v:
		return -1
	if flip_h:
		if transpose:
			return 3
		else:
			return 2
	else:
		if transpose:
			return 1
		else:
			return 0

func load_level():
	main_node.load_level(current_level)
	get_parent().queue_free()

