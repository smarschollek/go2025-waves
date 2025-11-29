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
    
    if GameManager.showEnemiesAreComing:
        $InfoLabel.text = "[color=red][shake rate=32 level=16]Enemies are coming"
    elif GameManager.showLastWaveApproaching:
        $InfoLabel.text = "[color=gold][shake rate=32 level=8]The last wave is approaching"
    else:
        $InfoLabel.text = ""

func _onLevelFinished(lost: bool) -> void:
    Engine.time_scale = 1.0
    
    var coins = get_tree().get_nodes_in_group("Coin")
    for coin in coins:
        coin.queue_free()

    DragAndDropManager.clear()

    get_tree().paused = true

    if lost:    
        $GameOver.visible = true
    else:
        $NextLevelDialog.visible = true



func _on_pause_button_button_up() -> void:
    get_tree().paused = !get_tree().paused

func _on_fast_forward_button_button_up() -> void:
    if Engine.time_scale == 1.0:
        Engine.time_scale = 2.5
    else:
        Engine.time_scale = 1.0
