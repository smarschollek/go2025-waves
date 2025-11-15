extends Area2D

func _on_area_entered(area: Area2D) -> void:
    queue_free()
    GameManager.triggerGameOver(true)
    area.get_parent().queue_free()
