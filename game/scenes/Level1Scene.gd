extends Node2D

func _ready() -> void:
    MoneyManager.reset()

    GameManager.setSceneRoot(self)
    GameManager.reset()
    GameManager.gameOver.connect(_on_game_over)

    ReportManager.initializeDay()
    
    TimeManager.gameTick.connect(timeManager_onGameTick)
    TimeManager.startGameTimer()

    Engine.time_scale = 1.0
    

    LevelUpManager.xpChanged.connect(_on_xpChanged)
    LevelUpManager.leveledUp.connect(_on_leveledUp)
    
    setProgressBar()

func setProgressBar() -> void:
    $ProgressBar.value = LevelUpManager.currentXP
    $ProgressBar.max_value = LevelUpManager.xpForNextLevel

func _on_xpChanged(currentXP: int) -> void:
    $ProgressBar.value = currentXP

func _on_leveledUp(_xpToNextLevel: int) -> void:
    $Level.text = "Level %d" % LevelUpManager.level
    setProgressBar()
    # get_tree().paused = true
    # $LevelUpDialog.visible = true

func _on_game_over(_lost: bool) -> void:
    TimeManager.stopGameTimer() 
    
    get_tree().change_scene_to_file("res://game/scenes/ReportScene.tscn")

func timeManager_onGameTick(_totalTick: int) -> void:
    var minutes = _totalTick / 60
    var seconds = _totalTick % 60

    $Clock.text = "%02d:%02d" % [minutes, seconds]
