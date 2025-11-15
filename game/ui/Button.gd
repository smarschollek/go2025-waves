@tool 
extends CenterContainer

signal onClick

@export var buttonText: String = "Button":
    set(value):
        buttonText = value
        $Label.text = buttonText

@export var buttonColor: Color = Color.RED:
    set(value):
        buttonColor = value
        $ButtonBase.modulate = value

# func _ready() -> void:
#     $Label.text = buttonText
#     $ButtonBase.modulate = buttonColor

func _on_button_base_mouse_exited() -> void:
    $ButtonBase.modulate = buttonColor

func _on_button_base_mouse_entered() -> void:
    $ButtonBase.modulate = buttonColor.lightened(0.2)


func _on_button_base_button_down() -> void:
    $ButtonBase.modulate = buttonColor


func _on_button_base_pressed() -> void:
    onClick.emit()
