extends Node



var currentDay: int = 0
var operatorName: String = "Doug #" + str(GameManager.getRandomInt(1, 1000))
var opationTime: int = 0
var killedUnits: int = 0

func initializeDay() -> void:
    print("initializeDay called")
    currentDay += 1
    opationTime = 0
    killedUnits = 0

func _init() -> void:
    TimeManager.onGameTick.connect(onGameTick)
    
    
func onGameTick(totalTicks: int) -> void:
    if totalTicks % 4 == 0:
        opationTime += 1