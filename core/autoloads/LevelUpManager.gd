extends Node

var currentXP: int = 0
var level: int = 1
var xpForNextLevel: int = 5

signal leveledUp(newLevel: int, xpForNextLevel: int)
signal xpChanged(currentXP: int)

func addXP(amount: int) -> void:
    currentXP += amount
    
    xpChanged.emit(currentXP)

    if currentXP >= xpForNextLevel:
        levelUp()

func levelUp() -> void:
    level += 1
    currentXP = 0
    xpForNextLevel = int(xpForNextLevel + 5)
    leveledUp.emit(xpForNextLevel)
        
    
