extends Area2D

@export var sprite : Texture2D

func _ready() -> void:
    $Sprite2D.texture = sprite
    $Sprite2D.modulate = Color(1, 1, 1, 0.7)

signal dropzone_entered(zone)
signal dropzone_exited(zone)

func _on_body_entered(body: Node2D) -> void:
    if GameManager.isDropzoneFree(body):
        emit_signal("dropzone_entered", body)

func _on_body_exited(body: Node2D) -> void:
    if GameManager.isDropzoneFree(body):
        emit_signal("dropzone_exited", body)
    
