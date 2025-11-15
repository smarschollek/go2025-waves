extends Node

var speedMultiplier := 1.0
var speedIncreaseInterval := 40
var speedIncreaseAmount := 0.05

func reset() -> void:
    speedMultiplier = 1.0

func _ready():
    TimeManager.onGameTick.connect(_on_game_tick)


func _on_game_tick(totalTick: int):
    if totalTick % speedIncreaseInterval == 0:
        increaseSpeed()
        
func increaseSpeed() -> void:
    if(speedMultiplier < 10.0):
        speedMultiplier += speedIncreaseAmount
    
        
    
    
