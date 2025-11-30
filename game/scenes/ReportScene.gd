extends CenterContainer

@onready var nameNode = $TextureRect/VBoxContainer/NameContainer/Text
@onready var levelNode = $TextureRect/VBoxContainer/Levelcontainer/Text
@onready var killedUnitsNode = $TextureRect/VBoxContainer/KilledUnitsContainer/Text
@onready var moneyCollectedNode = $TextureRect/VBoxContainer/CollectedMoneyContainer/Text
@onready var spentMoneyNode = $TextureRect/VBoxContainer/SpentMoneyContainer/Text

func _ready() -> void:
    get_tree().paused = false
    
    AudioManager.playBackgroundMusic(load("res://assets/audio/jazz.mp3"))

    nameNode.text = "Doug #" + str(SeededRNG.getRandomInt(1000, 9999))
    levelNode.text = str(GameManager.level)
    killedUnitsNode.text = str(GameManager.killedEnemies)
    moneyCollectedNode.text = str(GameManager.moneyCollected) + " WiZ"
    spentMoneyNode.text = str(GameManager.moneySpent) + " WiZ"

    Dialogic.timeline_ended.connect(_on_timeline_ended)
    Dialogic.start("res://data/dialogs/reportScene.dtl")

func _on_timeline_ended() -> void:
    Dialogic.timeline_ended.disconnect(_on_timeline_ended)
    get_tree().change_scene_to_file("res://game/scenes/MenuScene.tscn")

    
