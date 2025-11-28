extends Area2D

@export var coinValue: int
@export var soundEffect: AudioStream

signal collected

func _ready() -> void:
    coinValue = GameManager.coinValue
    self.z_index = GameManager.ZINDEX.UI

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
    if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
        collect()

func collect() -> void:
    AudioManager.playEffect(soundEffect, AudioManager.VOLUMEDB.EFFECT)
    MoneyManager.addMoney(coinValue)
    emit_signal("collected")
    queue_free()
    
    
