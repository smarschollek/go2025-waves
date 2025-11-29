extends Control

@onready var defenderContainer = $PanelContainer/CenterContainer/PanelContainer/VBoxContainer3/HBoxContainer/CenterContainer/NewDefenderContainer
@onready var textureReact = $PanelContainer/CenterContainer/PanelContainer/VBoxContainer3/HBoxContainer/CenterContainer/NewDefenderContainer/NewDefenderImage



var paths = [
    "res://assets/entites/Defenders/Swordsman/Swordsman-Idle.png",
    "res://assets/entites/Defenders/Priest/Priest-Idle.png",
    "res://assets/entites/Defenders/Frostmage/Frostmage-Idle.png",
    "res://assets/entites/Defenders/Knight Templar/Knight Templar-Idle.png"
]

func _ready() -> void:
    UpgradeManager.addPoints(1)
    defenderContainer.visible = GameManager.level <= 3    
    
    if defenderContainer.visible:
        var atlasTexture = AtlasTexture.new()
        atlasTexture.atlas = load(paths[GameManager.level - 1])
        atlasTexture.region = Rect2(43.0, 39.0, 17.0, 19.0)
        textureReact.texture = atlasTexture

func _on_next_level_button_button_up() -> void:
    get_tree().paused = false
    GameManager.loadNextLevel()
