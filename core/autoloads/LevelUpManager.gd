extends Node

const BASE = 5

var currentXP: int = 0
var level: int = 1

var xpForNextLevel: int = BASE

signal leveledUp(newLevel: int, xpForNextLevel: int)
signal xpChanged(currentXP: int)

func addXP(amount: int) -> void:
    currentXP += amount
    
    xpChanged.emit(currentXP)

    if currentXP >= xpForNextLevel:
        levelUp()

func levelUp() -> void:
    level += 1
    currentXP = currentXP - xpForNextLevel
    xpForNextLevel = xpRequired(level)
    
    leveledUp.emit(xpForNextLevel)

func xpRequired(nextLevel: int) -> int:
    var xp = BASE + (nextLevel - 1) * 10
    return int(xp)