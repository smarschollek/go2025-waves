extends PanelContainer

func _on_exit_button_button_up() -> void:
    get_tree().change_scene_to_packed(load("res://game/scenes/MenuScene.tscn"))

func _on_restart_button_button_up() -> void:
    GameManager.newGame()

	
