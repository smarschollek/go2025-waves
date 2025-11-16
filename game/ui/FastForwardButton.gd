extends Node2D



func _on_texture_button_toggled(toggled_on: bool) -> void:
    if toggled_on:
        Engine.time_scale = 5.0
    else:
        Engine.time_scale = 1.0
