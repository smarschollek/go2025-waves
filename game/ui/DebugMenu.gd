extends Node2D

@export var debugMode: bool = false

func _process(_delta: float) -> void:
    if debugMode and Input.is_action_just_pressed("ToggleDebugMenu"):
        self.visible = !self.visible
    pass


func _on_add_money_button_button_up() -> void:
    MoneyManager.addMoney(100)

