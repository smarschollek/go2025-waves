extends Node

var startMoney := 100
var totalMoney := 0

var passiveMoneyPerSecond: int = 25
var passiveMoneyIncreaseInterval: int = 20

func reset() -> void:
    totalMoney = startMoney

func _ready() -> void:
    reset()
    TimeManager.onGameTick.connect(_on_game_tick)

func _on_game_tick(totalTick: int) -> void:
    if totalTick % passiveMoneyIncreaseInterval == 0:
        totalMoney += passiveMoneyPerSecond

func addMoney(amount: int) -> void:
    totalMoney += amount

func hasEnoughMoney(amount: int) -> bool:
    return totalMoney >= amount

func spendMoney(amount: int) -> bool:
    if totalMoney >= amount:
        totalMoney -= amount
        return true
    return false