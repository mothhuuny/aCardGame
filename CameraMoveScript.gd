extends Node3D
var camera_rotation1 = 0
var camera_rotation2 = -28
var camera_rotation3 = -75
var lookAngle = 0.0
var waslookAngle = 0.0
var camera_positionX = 0.0
var camera_positionY = 1.376
var camera_positionZ = 1.078
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera_rotation1 = 0

# func camPosSet(): intended to stop waslookAngle from updating and stopping weerd shit
func _physics_process(delta):
	
	if (Input.is_action_just_pressed("camera_up")):
		if (lookAngle==camera_rotation2):
			waslookAngle = lookAngle
			camera_positionZ = camera_positionZ-1.0
			lookAngle = camera_rotation3
		elif (lookAngle==camera_rotation3):
			waslookAngle = lookAngle
			camera_positionZ = camera_positionZ+1.0
			lookAngle = camera_rotation1
	elif (Input.is_action_just_pressed("camera_down")):
		if (lookAngle==camera_rotation1):
			waslookAngle = lookAngle
			camera_positionZ = camera_positionZ-1.0
			lookAngle = camera_rotation3
		elif (lookAngle==camera_rotation3):
			waslookAngle = lookAngle
			camera_positionZ = camera_positionZ+1.0
			lookAngle = camera_rotation2
			
	rotation.x = lerp_angle(rotation.x,deg_to_rad(lookAngle),.3)
	position.z = lerp(position.z,camera_positionZ,.3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Fuzz Mouse
