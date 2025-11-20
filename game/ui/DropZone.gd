extends StaticBody2D



func _process(_delta: float) -> void:
    var disableCollision = checkIfOccupied()
    var showSprite = not disableCollision and GameManager.isDragging
    
    $Sprite2D.visible = showSprite
    $CollisionShape2D.disabled = disableCollision

func checkIfOccupied() -> bool:
    for child in get_children():
        if child.is_in_group("Defender"):
            return true

    return false
    