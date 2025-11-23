extends Node

var opationTime: int = 0
var killedUnits: int = 0

func initializeDay() -> void:
    GameManager.day += 1
    opationTime = 0
    killedUnits = 0

func _init() -> void:
    TimeManager.gameTick.connect(onGameTick)
    
    
func onGameTick(_totalTicks: int) -> void:
    opationTime += 1
