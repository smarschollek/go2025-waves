extends Node2D

func _on_hurtbox_died() -> void:
    $AnimatedSprite2D.play("Dead")
    await $AnimatedSprite2D.animation_finished
    queue_free()


func _on_detection_box_collision_detected(_target: Area2D) -> void:
    $AnimatedSprite2D.play("Block")
