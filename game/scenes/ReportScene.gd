extends CenterContainer

@onready var nameNode = $TextureRect/VBoxContainer/NameContainer/Text
@onready var levelNode = $TextureRect/VBoxContainer/Levelcontainer/Text
@onready var killedUnitsNode = $TextureRect/VBoxContainer/KilledUnitsContainer/Text
@onready var moneyCollectedNode = $TextureRect/VBoxContainer/CollectedMoneyContainer/Text
@onready var spentMoneyNode = $TextureRect/VBoxContainer/SpentMoneyContainer/Text

func _ready() -> void:
    nameNode.text = "Doug #" + str(SeededRNG.getRandomInt(1000, 9999))
    levelNode.text = str(GameManager.level)
    killedUnitsNode.text = str(GameManager.killedEnemies)
    moneyCollectedNode.text = str(GameManager.moneyCollected) + " WiZ"
    spentMoneyNode.text = str(GameManager.moneySpent) + " WiZ"

    pass