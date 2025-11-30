extends Control

func _ready() -> void:    
    AudioManager.playBackgroundMusic(load("res://assets/audio/jazz.mp3"))

func _on_play_button_on_click() -> void:    
    $CenterContainer.visible = false

    Dialogic.timeline_ended.connect(_on_timeline_ended)
    Dialogic.start("res://data/dialogs/tutorial.dtl")
    
func _on_timeline_ended() -> void:
    Dialogic.timeline_ended.disconnect(_on_timeline_ended)
    GameManager.newGame()   