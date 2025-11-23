extends CanvasLayer

func _ready() -> void:
    if OS.get_name() == "Web":
        $ExitButton.hide()

func _on_play_button_on_click() -> void:    
    GameManager.newGame()   
    GameManager.loadNextLevel()
    
    # $Background.material.set_shader_parameter("blur_amount", 20)
    # $CenterContainer.visible = false
    
    # Dialogic.timeline_ended.connect(switchToLevel)
    # Dialogic.start("menu")

    



func _on_exit_button_on_click() -> void:
    get_tree().quit()
