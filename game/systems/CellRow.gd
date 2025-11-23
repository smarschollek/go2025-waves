@tool
extends Node2D
class_name CellRow

@export var cellScene: PackedScene

@export var amount: int = 3:
    set(value):
        amount = value
        
        for child in get_children():
            child.queue_free()

        if cellScene:
            for i in value:
                var cell : Area2D = cellScene.duplicate().instantiate()
                add_child(cell)
                cell.position = Vector2(i * -64, 0)
    
