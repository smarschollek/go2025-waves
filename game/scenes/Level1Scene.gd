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

    LevelUpManager.xpChanged.connect(_on_xpChanged)
    LevelUpManager.leveledUp.connect(_on_leveledUp)
    
    setProgressBar()

func setProgressBar() -> void:
    $ProgressBar.value = LevelUpManager.currentXP
    $ProgressBar.max_value = LevelUpManager.xpForNextLevel

func _on_xpChanged(currentXP: int) -> void:
    $ProgressBar.value = currentXP

func _on_leveledUp(_xpToNextLevel: int) -> void:
    setProgressBar()
    get_tree().paused = true
    $LevelUpDialog.visible = true

func _on_game_over(_lost: bool) -> void:
    TimeManager.stopGameTimer() 
    
    get_tree().change_scene_to_file("res://game/scenes/ReportScene.tscn")