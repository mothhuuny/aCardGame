extends Node3D
var currentSleeve = "none"
var cardData = {}
#change this filepath to choose specific card JSON, to be changed to recieve signal when card instance is created
var dataFilePath = "res://cards/attributes/card1.json"
var cardName
var cardType
var cardHealth
var cardPoints
var cardAbilities
var isInHand = true
var isInSlot = false
func _ready():
	cardData = load_json_file(dataFilePath)
	#please ignore this fucking dogshit placeholder texture I drew in like 5 minutes
	$cardTexture.texture = load("res://cards/textures/" + cardData.get("texture"))
	cardName = cardData.get("name")
	cardType = cardData.get("type")
	cardHealth = cardData.get("health")
	cardPoints = cardData.get("points")
	cardAbilities = cardData.get("abilities")
#converts selected 
func load_json_file(filePath : String):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		if parsedResult is Dictionary:
			return parsedResult
		else:
			print("file not formatted correctly >:3")
	else: 
		print("file doesn't exist 3:")
		
