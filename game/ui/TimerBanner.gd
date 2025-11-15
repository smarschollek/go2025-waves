extends Node2D

var timer_duration: float = 600.0 

func _physics_process(_delta: float) -> void:
    $Label.text = str(GameManager.currentWave) + "/" + str(GameManager.totalWaves)
    
