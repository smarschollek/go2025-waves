extends Control

@onready var waveProgress = $ColorRect/WaveProgress
@onready var menuContainer = $PanelContainer

func _ready() -> void:
    GameManager.levelFinished.connect(_onLevelFinished)
    
    $NextLevelDialog.visible = false
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
        get_tree().change_scene_to_file.call_deferred("res://game/scenes/ReportScene.tscn")
    else:
        $NextLevelDialog.visible = true

func _on_fast_forward_button_button_down() -> void:
    if Engine.time_scale == 1.0:
        Engine.time_scale = 2.5
    else:
        Engine.time_scale = 1.0

func _on_continue_button_button_down() -> void:
    menuContainer.visible = false
    get_tree().paused = false

func _on_quit_button_button_down() -> void:
    menuContainer.get_child(0).visible = false
    Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS 
    var scene = Dialogic.start("res://data/dialogs/quitGame.dtl")
    scene.process_mode = Node.PROCESS_MODE_ALWAYS 
    Dialogic.signal_event.connect(_on_signal_event)
        

func _on_signal_event(argument: String) -> void:
    if argument == "yes":
        get_tree().paused = false
        get_tree().change_scene_to_file.call_deferred("res://game/scenes/MenuScene.tscn")
    elif argument == "no":
        menuContainer.get_child(0).visible = true
        pass

    Dialogic.signal_event.disconnect(_on_signal_event)
            

func _on_menu_button_button_down() -> void:
    menuContainer.visible = true
    get_tree().paused = true
