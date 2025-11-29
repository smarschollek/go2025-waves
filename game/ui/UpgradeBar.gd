@tool
extends Control

const MAXVALUE: int = 9

@export var defenderType: String = "wizard"
@export var upgradeType: String = "attackSpeed"

var value := 0

@export var iconTexture: Texture2D:
    set(value):
        iconTexture = value
        $Icon.texture = value

func _ready() -> void:
    if not Engine.is_editor_hint():
        var newValue = UpgradeManager.getDefenderValue(defenderType, upgradeType)
        setValue(newValue)
    
func _on_minus_button_button_up() -> void:
    var newValue = UpgradeManager.downgradeADefenders(defenderType, upgradeType)
    setValue(newValue)

func _on_plus_button_button_up() -> void:
    var newValue = UpgradeManager.upgradeDefender(defenderType, upgradeType)
    setValue(newValue)

func setValue(newValue: int) -> void:
    value = newValue
    $TextureProgressBar.value = value
