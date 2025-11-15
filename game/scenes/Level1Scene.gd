extends Node2D

func _ready() -> void:
    MoneyManager.reset()
    EnemyManager.reset()
    GameManager.reset()
    
    GameManager.gameOver.connect(_on_game_over)

    ReportManager.initializeDay()
    TimeManager.startGameTimer()
    Engine.time_scale = 1.0
    $SpawnManager.startSpawningWave()

    
func _on_game_over(_lost: bool) -> void:
    TimeManager.stopGameTimer() 
    
    get_tree().change_scene_to_file("res://game/scenes/ReportScene.tscn")