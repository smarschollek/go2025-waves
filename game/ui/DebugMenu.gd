extends Node2D

@export var debugMode: bool = false

func _ready() -> void:
    self.visible = debugMode

func _process(_delta: float) -> void:
    if debugMode and Input.is_action_just_pressed("ToggleDebugMenu"):
        self.visible = !self.visible
    pass


func _on_add_money_button_button_up() -> void:
    MoneyManager.addMoney(100)



func _on_add_cell_to_row_button_up() -> void:
    UpgradeManager.cellsPerRow += 1


func _on_add_10s_button_button_up() -> void:
    var spawnManager : SpawnManager = get_tree().get_first_node_in_group("SpawnManager")
    if spawnManager:
        print("Adding 10 seconds to game time")
        spawnManager.gameTime += 10


func _on_fast_forwad_button_button_up() -> void:
    if Engine.time_scale == 1.0:
        Engine.time_scale = 4.0
    else:
        Engine.time_scale = 1.0
