extends Node2D

func _ready() -> void:
    var x = global_position.x / -2.5
    $RayCast2D.target_position = Vector2(x, 0)

func _on_hurtbox_died() -> void:
    queue_free()
