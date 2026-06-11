extends Node3D

signal pRowSelect(slot: Node)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PlayerCamera/Camera3D.pRowHit.connect(_p_row_hit)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _p_row_hit(slot: Node):
	pRowSelect.emit(slot)
