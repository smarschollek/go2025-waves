extends CanvasLayer

func _ready() -> void:
    if OS.get_name() == "Web":
        $CenterContainer/VBoxContainer/ExitButton.hide()

    
    AudioManager.playBackgroundMusic(load("res://assets/audio/jazz.mp3"))

func _on_play_button_on_click() -> void:    
    $CenterContainer.visible = false

    Dialogic.timeline_ended.connect(_on_timeline_ended)
    Dialogic.start("res://data/dialogs/tutorial.dtl")
    

func _on_timeline_ended() -> void:
    Dialogic.timeline_ended.disconnect(_on_timeline_ended)
    GameManager.newGame()   

func _on_exit_button_on_click() -> void:
    get_tree().quit()
