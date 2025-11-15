extends StaticBody2D
    
func _process(_delta: float) -> void:
    if GameManager.isDragging and GameManager.isDropzoneFree(self):
        visible = true
    else:
        visible = false
    pass