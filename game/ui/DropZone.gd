extends StaticBody2D

func _process(_delta: float) -> void:
    var child  = getDefenderChild()
    var dropZoneOccupied  = child != null
    var showSprite = not dropZoneOccupied and DragAndDropManager.isDragging()
    
    $Sprite2D.visible = showSprite
    $CollisionShape2D.disabled = dropZoneOccupied
    
func getDefenderChild() -> Node:
    for child in get_children():
        if child.is_in_group("Defender"):    
            return child
    return null
    


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
    if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
        if DragAndDropManager.isDragging():
            DragAndDropManager.tryDrop(self)
