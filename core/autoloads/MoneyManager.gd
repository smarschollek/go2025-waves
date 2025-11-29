extends Node

var startMoney := 0

var totalMoney := 0:
    set(value):
        totalMoney = value
        moneyChanged.emit(totalMoney)

signal moneyChanged(newTotalMoney: int)

func reset() -> void:
    totalMoney = startMoney

func _ready() -> void:
    reset()

func addMoney(amount: int) -> void:
    totalMoney += amount
    
func hasEnoughMoney(amount: int) -> bool:
    return totalMoney >= amount

func spendMoney(amount: int) -> bool:
    if totalMoney >= amount:
        GameManager.moneySpent += amount
        totalMoney -= amount
        return true
    return false    