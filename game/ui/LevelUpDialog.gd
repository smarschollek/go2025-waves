extends AspectRatioContainer

func _on_button_button_up() -> void:
    print("Level Up Dialog: Continue button pressed")
    get_tree().paused = false
    self.visible = false
