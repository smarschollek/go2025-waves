extends Control

func _ready() -> void:
    $NextLevel.visible = false
    $Level.text = "Level %d" % GameManager.level

func updateRemainingWaveTime(remainingTime: int) -> void:
    if remainingTime == 0:
        showNextLevel()
    else:
        updateWaveTimeLabel(remainingTime)

func showNextLevel() -> void:
    get_tree().paused = true
    $NextLevel.visible = true    
    
func updateWaveTimeLabel(remainingTime: int) -> void:
    var minutes = int(remainingTime / 60)
    var seconds = remainingTime % 60
    $WaveTimeLabel.text = "Wave ends in: %02d:%02d" % [minutes, seconds]


func _on_skip_button_button_up() -> void:
    get_tree().paused = false
    GameManager.loadNextLevel()
