extends Node3D
var cardScene = preload("res://card.tscn")
var cardInstance
var isInHand = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().pRowSelect.connect(_prow_hit)
	cardInstance = cardScene.instantiate()
	add_child(cardInstance)
	cardInstance.scale = Vector3(1, 1, 1)
	cardInstance.rotation.x = deg_to_rad(180)
	print(cardInstance.global_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _prow_hit(slot: Node):
	cardInstance.reparent(slot.get_parent(), true)
	isInHand = false
func _physics_process(delta: float) -> void:
	if isInHand == false:
		cardInstance.rotation.x = lerp_angle(cardInstance.rotation.x, deg_to_rad(0), 0.3)
		cardInstance.global_position = cardInstance.global_position.lerp(cardInstance.get_parent().global_position, 0.3)
