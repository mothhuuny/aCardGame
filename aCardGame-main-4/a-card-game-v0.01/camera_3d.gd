extends Camera3D
const RAY_LEN = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = get_viewport().get_mouse_position()
		
		# Create the ray parameters from the camera's viewport
		var space_state = get_world_3d().direct_space_state
		var origin = project_ray_origin(mouse_pos)
		var end = origin + project_ray_normal(mouse_pos) * RAY_LEN
		var query = PhysicsRayQueryParameters3D.create(origin, end)
		
		# Execute the raycast
		var result = space_state.intersect_ray(query)
		if result:
			pRowHit.emit(result.collider)
			print("Hit object: ", result.collider)
		
signal pRowHit(slot: Node)
