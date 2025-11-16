extends Node2D



func _on_hurtbox_died() -> void:
    $AnimatedSprite2D.play("Dead")
