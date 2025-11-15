extends Node2D

func _ready() -> void:
    setMoneyFromGameManager()

func _process(_delta: float) -> void:
    setMoneyFromGameManager()

func setMoneyFromGameManager() -> void:
    $Label.text = str(MoneyManager.totalMoney)
    
