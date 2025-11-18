extends StaticBody2D
    
func _process(_delta: float) -> void:
    checkIfOccupied()

func checkIfOccupied() -> void:
    if get_child_count() == 3:
        $Sprite2D.visible = false
        $CollisionShape2D.disabled = true
    else:
        $Sprite2D.visible = true
        $CollisionShape2D.disabled = false