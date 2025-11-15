extends StaticBody2D

func _on_hurtbox_died() -> void:
	queue_free()
