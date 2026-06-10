extends Node3D
var cardScene = preload("res://card.tscn")
var pRows
var middleIndex
var cardsInHand = []
var selectedCard = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#create array of prow slot reference variables for bulk collision checks(i.e. "is this object touching any prow slot?"
	pRows = [get_node("/root/playRoom/Prow1"),get_node("/root/playRoom/Prow2"),get_node("/root/playRoom/Prow3"),get_node("/root/playRoom/Prow4"),get_node("/root/playRoom/Prow5")]
	get_parent().pRowSelect.connect(_prow_hit)
	#adds a starting card to the hand, initializes values
	cardsInHand.append(cardScene.instantiate())
	add_child(cardsInHand[selectedCard])
	cardsInHand[selectedCard].scale = Vector3(1, 1, 1)
	cardsInHand[selectedCard].rotation.x = deg_to_rad(180)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _prow_hit(slot: Node):
	#reparents card to selected slot and triggers lerp to move its global position to the slot
	if cardsInHand.size() > 0:
		cardsInHand[selectedCard].reparent(slot.get_parent(), true)
		cardsInHand[selectedCard].isInHand = false
func _physics_process(delta: float) -> void:
	#loops through every prow to check if card is in any slot
	for pRow in pRows:
		if cardsInHand.size() > 0:
			#detects card position being close enough to slot
			if pRow.global_position.is_equal_approx(cardsInHand[selectedCard].global_position):
				#stops lerp to lock card in place
				cardsInHand[selectedCard].isInSlot = true
				#snaps card position to slot to correct for tiny float variations caused by lerp
				cardsInHand[selectedCard].global_position = pRow.global_position
				#removes card from hand array
				cardsInHand.remove_at(selectedCard)
	if cardsInHand.size() > 0:
		#interpolates movement and rotation of cards being played to move them to the selected prow slot
		if cardsInHand[selectedCard].isInHand == false && cardsInHand[selectedCard].isInSlot == false:
			cardsInHand[selectedCard].rotation.x = lerp_angle(cardsInHand[selectedCard].rotation.x, deg_to_rad(0), 0.3)
			cardsInHand[selectedCard].global_position = cardsInHand[selectedCard].global_position.lerp(cardsInHand[selectedCard].get_parent().global_position, 0.3)
	
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("drawCard"):
		_draw_card()
		
func _draw_card():
	cardsInHand.append(cardScene.instantiate())
	selectedCard = cardsInHand.size() - 1
	add_child(cardsInHand[selectedCard])
	cardsInHand[selectedCard].scale = Vector3(1, 1, 1)
	cardsInHand[selectedCard].rotation.x = deg_to_rad(180)
	middleIndex = int(cardsInHand.size() / 2)
	cardsInHand[selectedCard].global_position.x = cardsInHand[selectedCard - 1].global_position.x + 0.1
	
	for card in cardsInHand:
		card.global_position.x -= 0.05
