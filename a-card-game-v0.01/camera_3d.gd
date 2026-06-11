extends Camera3D
@export var ray_length: float = 1000.0
signal pRowHit(slot: Node)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		shoot_ray_from_mouse(event.position)

func shoot_ray_from_mouse(mouse_position: Vector2) -> void:
	# Calculate ray origin and direction
	var from: Vector3 = project_ray_origin(mouse_position)
	var to: Vector3 = from + project_ray_normal(mouse_position) * ray_length
	
	# Query the physics space
	var space_state := get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(from, to)
	
	# Perform intersection check
	var result: Dictionary = space_state.intersect_ray(query)
	
	if not result.is_empty():
		pRowHit.emit(result.collider)
