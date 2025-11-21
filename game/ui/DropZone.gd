extends StaticBody2D



func _process(_delta: float) -> void:
    var disableCollision = checkIfOccupied()
    var showSprite = not disableCollision and DragAndDropManager.isDragging()
    
    $Sprite2D.visible = showSprite
    $CollisionShape2D.disabled = disableCollision

func checkIfOccupied() -> bool:
    for child in get_children():
        if child.is_in_group("Defender"):
            return true

    return false
    


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
    if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
        if DragAndDropManager.isDragging():
            DragAndDropManager.tryDrop(self)
