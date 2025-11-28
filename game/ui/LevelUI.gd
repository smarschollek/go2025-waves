extends Control

@onready var waveProgress = $ColorRect/WaveProgress

func _ready() -> void:
    GameManager.levelFinished.connect(_onLevelFinished)
    

    $NextLevelDialog.visible = false
    $GameOver.visible = false
    $Level.text = "Level %d" % GameManager.level

func _physics_process(_delta: float) -> void:
    waveProgress.max_value = GameManager.waveTimeInSeconds
    waveProgress.value = GameManager.currentWaveTimeInSeconds
    
    $PrepareYourselfLabel.visible = GameManager.showLastWaveApproaching

func _onLevelFinished(lost: bool) -> void:
    get_tree().paused = true

    if lost:    
        $GameOver.visible = true
    else:
        $NextLevelDialog.visible = true

