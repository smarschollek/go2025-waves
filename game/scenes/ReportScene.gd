extends Node2D

func _ready() -> void:
    $DailyReport.day = GameManager.day
    $DailyReport.operatorName = GameManager.operatorName
    
    Dialogic.signal_event.connect(_on_dialogue_signal_events)
    Dialogic.start("level1_report")
    
func _on_dialogue_signal_events(argument: String) -> void:
    if argument == "quit":
        GameManager.saveGame()
        get_tree().change_scene_to_file("res://game/scenes/MenuScene.tscn")

    if argument == "nextLevel":
        GameManager.saveGame()
        get_tree().change_scene_to_file("res://game/scenes/Level2Intro.tscn")

    if argument == "restart":
        get_tree().change_scene_to_file("res://game/scenes/Level1Scene.tscn")
    

    
