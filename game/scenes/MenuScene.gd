extends CanvasLayer

@onready var continueButton = $CenterContainer/VBoxContainer/HBoxContainer/ContinueButton

func _ready() -> void:
    if GameManager.saveFileExists():
        continueButton.visible = true
    else:
        continueButton.visible = false

    if OS.get_name() == "Web":
        $ExitButton.hide()

func _on_play_button_on_click() -> void:    
    GameManager.newGame()   

    $Background.material.set_shader_parameter("blur_amount", 20)
    $CenterContainer.visible = false
    
    Dialogic.timeline_ended.connect(switchToLevel)
    Dialogic.start("menu")

func switchToLevel() -> void:
    get_tree().change_scene_to_file("res://game/scenes/Level1Scene.tscn")

func _on_exit_button_on_click() -> void:
    get_tree().quit()
