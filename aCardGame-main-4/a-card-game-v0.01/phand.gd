extends Node3D
const CARD_SCENE = preload("res://card.tscn")
var cardInstance

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().pRowSelect.connect(_on_prow_hit)
	cardInstance = CARD_SCENE.instantiate()
	#cardInstance.dataFilePath = "res://cards/attributes/card1.json"
	add_child(cardInstance)
	#cardInstance.global_position = Vector3(0.2, 1.2, 1.3)
	cardInstance.rotation = Vector3(-90, 0, 0)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_prow_hit(slot: Node):
	cardInstance.reparent(slot.get_parent())
