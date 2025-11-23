extends Node2D

@export var playBackgroundMusic: AudioStream



func _ready() -> void:
    MoneyManager.reset()

    GameManager.setSceneRoot(self)
    GameManager.reset()
    GameManager.gameOver.connect(_on_game_over)

    ReportManager.initializeDay()

    TimeManager.startGameTimer()

    Engine.time_scale = 1.0

    AudioManager.playBackgroundMusic(playBackgroundMusic)

    setRows()
    
func setRows():
    $CellRows/CellRow1.amount = UpgradeManager.cellsPerRow
    $CellRows/CellRow2.amount = UpgradeManager.cellsPerRow
    $CellRows/CellRow3.amount = UpgradeManager.cellsPerRow

func _on_game_over(_lost: bool) -> void:
    TimeManager.stopGameTimer() 
    
    get_tree().change_scene_to_file("res://game/scenes/ReportScene.tscn")



    

    
